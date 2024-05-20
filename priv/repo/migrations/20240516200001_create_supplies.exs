defmodule HomerSalgateria.Repo.Migrations.CreateSupplies do
  use Ecto.Migration

  def change do
    create table(:supplies) do
      add :nome, :string
      add :tipo, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:supplies, [:nome], name: :supplies_nome_index)
  end
end
