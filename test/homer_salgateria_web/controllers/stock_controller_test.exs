defmodule HomerSalgateriaWeb.StockControllerTest do
  use HomerSalgateriaWeb.ConnCase

  import HomerSalgateria.ProductsFixtures

  @create_attrs %{data_validade: ~D[2024-05-16], quantidade: "120.5"}
  @update_attrs %{data_validade: ~D[2024-05-17], quantidade: "456.7"}
  @invalid_attrs %{data_validade: nil, quantidade: nil}

  describe "index" do
    test "lists all stocks", %{conn: conn} do
      conn = get(conn, ~p"/stocks")
      assert html_response(conn, 200) =~ "Listing Stocks"
    end
  end

  describe "new stock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/stocks/new")
      assert html_response(conn, 200) =~ "New Stock"
    end
  end

  describe "create stock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/stocks", stock: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/stocks/#{id}"

      conn = get(conn, ~p"/stocks/#{id}")
      assert html_response(conn, 200) =~ "Stock #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/stocks", stock: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stock"
    end
  end

  describe "edit stock" do
    setup [:create_stock]

    test "renders form for editing chosen stock", %{conn: conn, stock: stock} do
      conn = get(conn, ~p"/stocks/#{stock}/edit")
      assert html_response(conn, 200) =~ "Edit Stock"
    end
  end

  describe "update stock" do
    setup [:create_stock]

    test "redirects when data is valid", %{conn: conn, stock: stock} do
      conn = put(conn, ~p"/stocks/#{stock}", stock: @update_attrs)
      assert redirected_to(conn) == ~p"/stocks/#{stock}"

      conn = get(conn, ~p"/stocks/#{stock}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, stock: stock} do
      conn = put(conn, ~p"/stocks/#{stock}", stock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock"
    end
  end

  describe "delete stock" do
    setup [:create_stock]

    test "deletes chosen stock", %{conn: conn, stock: stock} do
      conn = delete(conn, ~p"/stocks/#{stock}")
      assert redirected_to(conn) == ~p"/stocks"

      assert_error_sent 404, fn ->
        get(conn, ~p"/stocks/#{stock}")
      end
    end
  end

  defp create_stock(_) do
    stock = stock_fixture()
    %{stock: stock}
  end
end
