defmodule HomerSalgateria.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:cpf, :email, :nome, :senha, :numero_telefone, :data_nascimento]

  schema "users" do
    field :cpf, :string
    field :email, :string
    field :nome, :string
    field :senha, :string
    field :numero_telefone, :string
    field :data_nascimento, :date
    field :funcao, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def validate_register(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @required)
    |> validate_required(@required, message: "Preencha o campo")
    |> validate_email()
    |> validate_length(:cpf, is: 11, message: "Insira um CPF válido")
    |> validate_length(:numero_telefone, is: 11, message: "Insira um número de telefone válido")
    |> validate_length(:nome, min: 2, max: 60, message: "Insira um nome válido")
    |> unique_constraint(:cpf, name: :users_cpf_index)
    |> unsafe_validate_unique(:cpf, HomerSalgateria.Repo, message: "Este CPF já está em uso")
    |> unique_constraint(:email, name: :users_email_index)
    |> unsafe_validate_unique(:email, HomerSalgateria.Repo, message: "Este Email já está em uso")
    |> change(funcao: "cliente")
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{senha: senha}} = changeset) do
    change(changeset, senha: Argon2.hash_pwd_salt(senha))
  end

  defp put_password_hash(changeset), do: changeset

  defp validate_email(user),
    do: validate_format(user, :email, ~r/@/, message: "Insira um Email válido")

  def validate_login(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:email, :senha])
    |> validate_required([:email, :senha])
    |> validate_email()
  end

  def validate_req_reset_password(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required(:email)
    |> validate_email()
  end
end
