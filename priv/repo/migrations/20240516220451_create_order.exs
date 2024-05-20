defmodule HomerSalgateria.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:order) do
      add :client_id, references(:users)
      add :employee_id, references(:users)

      timestamps(type: :utc_datetime)
    end
  end
end
