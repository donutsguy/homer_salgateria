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
  def registration_changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @required)
    |> validate_required(@required, message: "Preencha o campo")
    |> validate_email()
    |> validate_unique_email()
    |> validate_cpf()
    |> validate_unique_cpf()
    |> validate_senha()
    |> validate_numero_telefone()
    |> validate_nome()
    |> add_cliente()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{senha: senha}} = changeset) do
    change(changeset, senha: Argon2.hash_pwd_salt(senha))
  end

  defp put_password_hash(changeset), do: changeset

  def email_changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_email()
  end

  def senha_changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:senha])
    |> validate_senha()
    |> put_password_hash()
  end

  defp validate_email(user),
    do: user |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Insira um Email válido")

  defp validate_unique_email(user) do
    user
    |> unsafe_validate_unique(:email, HomerSalgateria.Repo, message: "Este Email já está em uso")
    |> unique_constraint(:email, name: :users_email_index)
  end

  defp validate_cpf(user),
    do: user |> validate_length(:cpf, is: 11, message: "Insira um CPF válido")

  defp validate_unique_cpf(user) do
    user
    |> unsafe_validate_unique(:cpf, HomerSalgateria.Repo, message: "Este CPF já está em uso")
    |> unique_constraint(:cpf, name: :users_cpf_index)

    # ideal case
    # if Keyword.get(attrs, :validate_cpf, true) do
    #  user
    #  |> unsafe_validate_unique(:cpf, HomerSalgateria.Repo, message: "Este CPF já está em uso")
    #  |> unique_constraint(:cpf, name: :users_cpf_index)
    # else
    #  user
    # end
  end

  defp validate_numero_telefone(user),
    do:
      validate_length(user, :numero_telefone,
        is: 11,
        message: "Insira um número de telefone válido"
      )

  defp validate_nome(user),
    do: validate_length(user, :nome, min: 2, max: 60, message: "Insira um nome válido")

  defp validate_senha(user) do
    user
    |> validate_length(:senha,
      min: 8,
      max: 60,
      message: "Insira uma senha com no mínimo 8 caracteres"
    )
    |> validate_confirmation(:senha, message: "As senhas não são iguais")
    |> put_password_hash()
  end

  defp add_cliente(user), do: change(user, funcao: "cliente")

  # login changesets and validations

  def login_changeset(user \\ %__MODULE__{}, attrs), do: validate_login(user, attrs)

  defp validate_login(user, attrs) do
    user
    |> cast(attrs, [:email, :senha])
    |> validate_required([:email, :senha])
    |> validate_email()
  end

  # reset password changesets and validations

  def email_reset_password_changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required(:email)
    |> validate_email()
  end

  def change_password_changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:senha])
    |> validate_senha()
  end
end
