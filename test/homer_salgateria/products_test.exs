defmodule HomerSalgateria.ProductsTest do
  use HomerSalgateria.DataCase

  alias HomerSalgateria.Products

  describe "stocks" do
    alias HomerSalgateria.Products.Stock

    import HomerSalgateria.ProductsFixtures

    @invalid_attrs %{data_validade: nil, quantidade: nil}

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Products.list_stocks() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Products.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{data_validade: ~D[2024-05-16], quantidade: "120.5"}

      assert {:ok, %Stock{} = stock} = Products.create_stock(valid_attrs)
      assert stock.data_validade == ~D[2024-05-16]
      assert stock.quantidade == Decimal.new("120.5")
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{data_validade: ~D[2024-05-17], quantidade: "456.7"}

      assert {:ok, %Stock{} = stock} = Products.update_stock(stock, update_attrs)
      assert stock.data_validade == ~D[2024-05-17]
      assert stock.quantidade == Decimal.new("456.7")
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_stock(stock, @invalid_attrs)
      assert stock == Products.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Products.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Products.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Products.change_stock(stock)
    end
  end
end
