defmodule HomerSalgateria.Repo.Migrations.CreateItemStock do
  use Ecto.Migration

  def change do
    create table(:item_stock, primary_key: false) do
      add :item_id, references(:item)
      add :stock_id, references(:stock)

      timestamps(type: :utc_datetime)
    end
  end
end
