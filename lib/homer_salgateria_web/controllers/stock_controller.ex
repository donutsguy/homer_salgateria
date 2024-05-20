defmodule HomerSalgateriaWeb.StockController do
  use HomerSalgateriaWeb, :controller

  alias HomerSalgateria.{Products, SupplyStock}
  alias HomerSalgateria.SupplyStock.Stock

  def index(conn, _params) do
    stocks = SupplyStock.list_stocks()
    render(conn, :index, stocks: stocks)
  end

  def new(conn, _params) do
    produtos = Products.get_products_ids()

    changeset = SupplyStock.change_stock(%Stock{})

    render(conn, :new, changeset: changeset, produtos: produtos)
  end

  def create(conn, %{"stock" => stock_params}) do
    case SupplyStock.create_stock(stock_params) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Produto estocado com sucesso.")
        |> redirect(to: ~p"/stocks/#{stock}")

      {:error, %Ecto.Changeset{} = changeset} ->
        produtos = Products.get_products_ids()
        render(conn, :new, changeset: changeset, produtos: produtos)
    end
  end

  def show(conn, %{"id" => id}) do
    stock = SupplyStock.get_stock!(id)
    render(conn, :show, stock: stock)
  end

  def delete(conn, %{"id" => id}) do
    stock = SupplyStock.get_stock!(id)
    {:ok, _stock} = SupplyStock.delete_stock(stock)

    conn
    |> put_flash(:info, "Produto excluido do estoque com sucesso.")
    |> redirect(to: ~p"/stocks")
  end
end
