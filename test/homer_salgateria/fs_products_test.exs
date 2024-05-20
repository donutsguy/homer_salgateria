defmodule HomerSalgateria.FSProductsTest do
  use HomerSalgateria.DataCase

  alias HomerSalgateria.FSProducts

  describe "supplies" do
    alias HomerSalgateria.FSProducts.Supply

    import HomerSalgateria.FSProductsFixtures

    @invalid_attrs %{nome: nil, tipo: nil}

    test "list_supplies/0 returns all supplies" do
      supply = supply_fixture()
      assert FSProducts.list_supplies() == [supply]
    end

    test "get_supply!/1 returns the supply with given id" do
      supply = supply_fixture()
      assert FSProducts.get_supply!(supply.id) == supply
    end

    test "create_supply/1 with valid data creates a supply" do
      valid_attrs = %{nome: "some nome", tipo: "some tipo"}

      assert {:ok, %Supply{} = supply} = FSProducts.create_supply(valid_attrs)
      assert supply.nome == "some nome"
      assert supply.tipo == "some tipo"
    end

    test "create_supply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FSProducts.create_supply(@invalid_attrs)
    end

    test "update_supply/2 with valid data updates the supply" do
      supply = supply_fixture()
      update_attrs = %{nome: "some updated nome", tipo: "some updated tipo"}

      assert {:ok, %Supply{} = supply} = FSProducts.update_supply(supply, update_attrs)
      assert supply.nome == "some updated nome"
      assert supply.tipo == "some updated tipo"
    end

    test "update_supply/2 with invalid data returns error changeset" do
      supply = supply_fixture()
      assert {:error, %Ecto.Changeset{}} = FSProducts.update_supply(supply, @invalid_attrs)
      assert supply == FSProducts.get_supply!(supply.id)
    end

    test "delete_supply/1 deletes the supply" do
      supply = supply_fixture()
      assert {:ok, %Supply{}} = FSProducts.delete_supply(supply)
      assert_raise Ecto.NoResultsError, fn -> FSProducts.get_supply!(supply.id) end
    end

    test "change_supply/1 returns a supply changeset" do
      supply = supply_fixture()
      assert %Ecto.Changeset{} = FSProducts.change_supply(supply)
    end
  end
end
