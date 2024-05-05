defmodule HomerSalgateriaWeb.SessionController do
  use HomerSalgateriaWeb, :controller

  alias HomerSalgateria.{Account, Account.User, Account.Guardian}

  def new(conn, _) do
    changeset = Account.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: ~p"/protected")
    else
      render(conn, :new, changeset: changeset, action: ~p"/login")
    end
  end

  def login(conn, %{"user" => %{"email" => email, "senha" => senha}}) do
    Account.authenticate_user(email, senha)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: ~p"/login")
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
end
