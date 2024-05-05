defmodule HomerSalgateria.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

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
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:cpf, :email, :nome, :senha, :numero_telefone, :data_nascimento])
    |> validate_required([:cpf, :email, :nome, :senha, :numero_telefone, :data_nascimento])
    |> put_password_hash()
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:numero_telefone, is: 11)
    |> validate_length(:nome, min: 2, max: 60)
    |> change(funcao: "cliente")
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{senha: senha}} = changeset) do
    change(changeset, senha: Argon2.hash_pwd_salt(senha))
  end

  defp put_password_hash(changeset), do: changeset
end
