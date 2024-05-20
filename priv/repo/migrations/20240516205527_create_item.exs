defmodule HomerSalgateria.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:item) do
      add :nome, :string
      add :tipo, :string
      add :preco, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
