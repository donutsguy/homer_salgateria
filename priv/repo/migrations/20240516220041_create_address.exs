defmodule HomerSalgateria.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:address) do
      add :cep, :string
      add :rua, :string
      add :numero_residencia, :string

      timestamps(type: :utc_datetime)
    end
  end
end
