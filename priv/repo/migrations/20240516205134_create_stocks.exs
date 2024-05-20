defmodule HomerSalgateria.Repo.Migrations.CreateStock do
  use Ecto.Migration

  def change do
    create table(:stock) do
      add :supply_id, references(:supplies), null: false
      add :data_validade, :date
      add :quantidade, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
