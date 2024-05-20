defmodule HomerSalgateria.SupplyStockTest do
  use HomerSalgateria.DataCase

  alias HomerSalgateria.SupplyStock

  describe "stocks" do
    alias HomerSalgateria.SupplyStock.Stock

    import HomerSalgateria.SupplyStockFixtures

    @invalid_attrs %{id: nil}

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert SupplyStock.list_stocks() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert SupplyStock.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{id: 42}

      assert {:ok, %Stock{} = stock} = SupplyStock.create_stock(valid_attrs)
      assert stock.id == 42
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SupplyStock.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{id: 43}

      assert {:ok, %Stock{} = stock} = SupplyStock.update_stock(stock, update_attrs)
      assert stock.id == 43
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = SupplyStock.update_stock(stock, @invalid_attrs)
      assert stock == SupplyStock.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = SupplyStock.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> SupplyStock.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = SupplyStock.change_stock(stock)
    end
  end
end
