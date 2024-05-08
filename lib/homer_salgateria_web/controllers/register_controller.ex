defmodule HomerSalgateriaWeb.RegisterController do
  use HomerSalgateriaWeb, :controller

  alias HomerSalgateria.Account
  alias HomerSalgateria.Account.User

  # Função de listar usuários, mover pro admin
  # def index(conn, _params) do
  #   users = Account.list_users()
  #   render(conn, :index, users: users)
  # end

  def new(conn, _params) do
    changeset = Account.change_user(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Account.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: ~p"/user/login/new")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, :show, user: user)
  end
end
