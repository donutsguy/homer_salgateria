defmodule HomerSalgateriaWeb.UserSessionController do
  use HomerSalgateriaWeb, :controller

  alias HomerSalgateria.{Account, Account.User, Account.Guardian}

  def new(conn, _) do
    changeset = Account.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: ~p"/protected")
    else
      render(conn, :new, changeset: changeset, action: ~p"/user/login/new")
    end
  end

  def create(conn, %{"user" => %{"email" => email, "senha" => senha}}) do
    Account.authenticate_user(email, senha)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: ~p"/user/login/new")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: ~p"/protected")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end

  def edit(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    changeset = Account.change_user(user)
    render(conn, :edit, user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    case Account.update_user(user, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: ~p"/protected")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, user: user, changeset: changeset)
    end
  end
end
