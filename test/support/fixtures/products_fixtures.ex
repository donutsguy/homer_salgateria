defmodule HomerSalgateria.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HomerSalgateria.FSProducts` context.
  """

  @doc """
  Generate a supply.
  """
  def supply_fixture(attrs \\ %{}) do
    {:ok, supply} =
      attrs
      |> Enum.into(%{
        nome: "some nome",
        tipo: "some tipo"
      })
      |> HomerSalgateria.Products.create_supply()

    supply
  end

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{
        data_validade: ~D[2024-05-16],
        quantidade: "120.5"
      })
      |> HomerSalgateria.SupplyStock.create_stock()

    stock
  end
end
