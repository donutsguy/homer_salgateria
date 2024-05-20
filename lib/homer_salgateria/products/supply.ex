defmodule HomerSalgateria.Products.Supply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "supplies" do
    field :nome, :string
    field :tipo, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(supply, attrs) do
    supply
    |> cast(attrs, [:nome, :tipo])
    |> validate_required([:nome, :tipo])
  end
end
