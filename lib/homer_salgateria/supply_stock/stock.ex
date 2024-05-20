defmodule HomerSalgateria.SupplyStock.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock" do
    field :supply_id, :integer
    field :data_validade, :date
    field :quantidade, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:supply_id, :data_validade, :quantidade])
    |> validate_required([:supply_id, :data_validade, :quantidade])
  end
end
