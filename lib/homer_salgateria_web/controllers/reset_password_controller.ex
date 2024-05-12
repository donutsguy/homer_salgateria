defmodule HomerSalgateriaWeb.ResetPasswordController do
  use HomerSalgateriaWeb, :controller
  # new, create, update, edit

  alias HomerSalgateria.{Account, Account.User}

  def new(conn, _params) do
    changeset = Account.change_req_reset_password(%User{})

    render(conn, :new, changeset: changeset, action: ~p"/user/reset_password/")
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    case user = Account.get_user_email!(email) do
      Ecto.NoResultsError ->
        conn
        |> put_flash(:info, "Enviamos um email de recuperação de senha para #{email}")

      email ->
        # with {:ok, token, _full_claims} <- Guardian.encode_and_sign(email)

        conn
        |> put_flash(:info, "Enviamos um email de recuperação de senha para #{email}")

        # deliver(email)
    end
  end
end
