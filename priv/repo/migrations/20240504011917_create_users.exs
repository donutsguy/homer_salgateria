defmodule HomerSalgateria.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :cpf, :string
      add :email, :string
      add :nome, :string
      add :senha, :string
      add :numero_telefone, :string
      add :data_nascimento, :date
      add :funcao, :string

      timestamps(type: :utc_datetime)
    end
  end
end
