defmodule HomerSalgateriaWeb.SupplyControllerTest do
  use HomerSalgateriaWeb.ConnCase

  import HomerSalgateria.FSProductsFixtures

  @create_attrs %{nome: "some nome", tipo: "some tipo"}
  @update_attrs %{nome: "some updated nome", tipo: "some updated tipo"}
  @invalid_attrs %{nome: nil, tipo: nil}

  describe "index" do
    test "lists all supplies", %{conn: conn} do
      conn = get(conn, ~p"/supplies")
      assert html_response(conn, 200) =~ "Listing Supplies"
    end
  end

  describe "new supply" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/supplies/new")
      assert html_response(conn, 200) =~ "New Supply"
    end
  end

  describe "create supply" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/supplies", supply: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/supplies/#{id}"

      conn = get(conn, ~p"/supplies/#{id}")
      assert html_response(conn, 200) =~ "Supply #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/supplies", supply: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Supply"
    end
  end

  describe "edit supply" do
    setup [:create_supply]

    test "renders form for editing chosen supply", %{conn: conn, supply: supply} do
      conn = get(conn, ~p"/supplies/#{supply}/edit")
      assert html_response(conn, 200) =~ "Edit Supply"
    end
  end

  describe "update supply" do
    setup [:create_supply]

    test "redirects when data is valid", %{conn: conn, supply: supply} do
      conn = put(conn, ~p"/supplies/#{supply}", supply: @update_attrs)
      assert redirected_to(conn) == ~p"/supplies/#{supply}"

      conn = get(conn, ~p"/supplies/#{supply}")
      assert html_response(conn, 200) =~ "some updated nome"
    end

    test "renders errors when data is invalid", %{conn: conn, supply: supply} do
      conn = put(conn, ~p"/supplies/#{supply}", supply: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Supply"
    end
  end

  describe "delete supply" do
    setup [:create_supply]

    test "deletes chosen supply", %{conn: conn, supply: supply} do
      conn = delete(conn, ~p"/supplies/#{supply}")
      assert redirected_to(conn) == ~p"/supplies"

      assert_error_sent 404, fn ->
        get(conn, ~p"/supplies/#{supply}")
      end
    end
  end

  defp create_supply(_) do
    supply = supply_fixture()
    %{supply: supply}
  end
end
