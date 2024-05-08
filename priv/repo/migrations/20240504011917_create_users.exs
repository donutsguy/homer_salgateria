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

    create unique_index(:users, [:cpf], name: :users_cpf_index)
    create unique_index(:users, [:email], name: :users_email_index)
  end
end
