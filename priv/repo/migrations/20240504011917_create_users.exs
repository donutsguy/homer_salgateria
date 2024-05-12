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

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
