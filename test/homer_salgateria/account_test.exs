defmodule HomerSalgateria.AccountTest do
  use HomerSalgateria.DataCase

  alias HomerSalgateria.Account

  describe "users" do
    alias HomerSalgateria.Account.User

    import HomerSalgateria.AccountFixtures

    @invalid_attrs %{cpf: nil, email: nil, nome: nil, senha: nil, numero_telefone: nil, data_nascimento: nil, funcao: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{cpf: "some cpf", email: "some email", nome: "some nome", senha: "some senha", numero_telefone: "some numero_telefone", data_nascimento: ~D[2024-05-03], funcao: "some funcao"}

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.cpf == "some cpf"
      assert user.email == "some email"
      assert user.nome == "some nome"
      assert user.senha == "some senha"
      assert user.numero_telefone == "some numero_telefone"
      assert user.data_nascimento == ~D[2024-05-03]
      assert user.funcao == "some funcao"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{cpf: "some updated cpf", email: "some updated email", nome: "some updated nome", senha: "some updated senha", numero_telefone: "some updated numero_telefone", data_nascimento: ~D[2024-05-04], funcao: "some updated funcao"}

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.cpf == "some updated cpf"
      assert user.email == "some updated email"
      assert user.nome == "some updated nome"
      assert user.senha == "some updated senha"
      assert user.numero_telefone == "some updated numero_telefone"
      assert user.data_nascimento == ~D[2024-05-04]
      assert user.funcao == "some updated funcao"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
