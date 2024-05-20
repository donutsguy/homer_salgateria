defmodule HomerSalgateriaWeb.SupplyController do
  use HomerSalgateriaWeb, :controller

  @tipos [
    "Bebida",
    "Enlatado",
    "Conserva",
    "Tempero",
    "Gordura",
    "Laticínio",
    "Farinha",
    "Insumo Auxiliar",
    "Carne",
    "Legume",
    "Vegetal",
    "Fermento"
  ]

  alias HomerSalgateria.Products
  alias HomerSalgateria.Products.Supply

  def index(conn, _params) do
    supplies = Products.list_supplies()
    render(conn, :index, supplies: supplies)
  end

  def new(conn, _params) do
    changeset = Products.change_supply(%Supply{})
    render(conn, :new, changeset: changeset, tipos: @tipos)
  end

  def create(conn, %{"supply" => supply_params}) do
    case Products.create_supply(supply_params) do
      {:ok, supply} ->
        conn
        |> put_flash(:info, "Insumo criado com sucesso!.")
        |> redirect(to: ~p"/supplies/#{supply}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, tipos: @tipos)
    end
  end

  def show(conn, %{"id" => id}) do
    supply = Products.get_supply!(id)
    render(conn, :show, supply: supply)
  end

  def edit(conn, %{"id" => id}) do
    supply = Products.get_supply!(id)
    changeset = Products.change_supply(supply)
    render(conn, :edit, supply: supply, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supply" => supply_params}) do
    supply = Products.get_supply!(id)

    case Products.update_supply(supply, supply_params) do
      {:ok, supply} ->
        conn
        |> put_flash(:info, "Insumo criado com sucesso!.")
        |> redirect(to: ~p"/supplies/#{supply}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, supply: supply, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supply = Products.get_supply!(id)
    {:ok, _supply} = Products.delete_supply(supply)

    conn
    |> put_flash(:info, "Insumo deletado com sucesso!.")
    |> redirect(to: ~p"/supplies")
  end
end
