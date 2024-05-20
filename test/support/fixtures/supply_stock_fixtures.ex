defmodule HomerSalgateria.SupplyStockFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HomerSalgateria.SupplyStock` context.
  """

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{
        id: 42
      })
      |> HomerSalgateria.SupplyStock.create_stock()

    stock
  end
end
