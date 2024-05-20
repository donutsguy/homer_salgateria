defmodule HomerSalgateria.Repo.Migrations.CreateItemOrder do
  use Ecto.Migration

  def change do
    create table(:item_order, primary_key: false) do
      add :item_id, references(:item)
      add :order_id, references(:order)

      timestamps(type: :utc_datetime)
    end
  end
end
