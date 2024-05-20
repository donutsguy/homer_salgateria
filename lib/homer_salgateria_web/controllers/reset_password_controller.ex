defmodule HomerSalgateriaWeb.ResetPasswordController do
  use HomerSalgateriaWeb, :controller
  # new, create, update, edit

  alias HomerSalgateria.{
    Account,
    Account.User,
    Account.UserNotifier,
    Account.UserToken
  }

  plug :get_user_by_reset_password_token when action in [:edit, :update]

  def new(conn, _params) do
    changeset = Account.change_req_reset_password(%User{})

    render(conn, :new, changeset: changeset, action: ~p"/user/reset_password/")
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    case Account.get_user_email(email) do
      nil ->
        password_redirect_message(conn, email)

      user ->
        {token, instructions_struct} = UserToken.build_change_password_token(user, user.email)

        Account.insert_password_instructions(instructions_struct)

        UserNotifier.deliver_reset_password_instructions(user, token)

        password_redirect_message(conn, email)
    end
  end

  def edit(conn, _params) do
    render(conn, :edit, changeset: Account.change_req_reset_password(%User{}))

    # render(conn, :edit, changeset: changeset, action: ~p"/user/reset_password/#{token}")
  end

  defp password_redirect_message(conn, email) do
    conn
    |> put_flash(:info, "Enviamos um email de recuperação de senha para #{email}")
    |> redirect(to: ~p"/user/login/new")
  end

  def update(conn, %{"user" => params}) do
    case Account.reset_user_password(conn.assigns.user, params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Senha alterada com sucesso.")
        |> redirect(to: ~p"/user/login/new")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end

  defp get_user_by_reset_password_token(conn, _opts) do
    %{"id" => token} = conn.params

    case Account.get_user_by_reset_password_token(token) do
      %User{} = user ->
        conn |> assign(:user, user) |> assign(:token, token)

      nil ->
        conn
        |> put_flash(:error, "Link de alteração de senha é inválido ou já expirou.")
        |> redirect(to: ~p"/")
        |> halt()
    end
  end
end
