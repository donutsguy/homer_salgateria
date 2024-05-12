defmodule HomerSalgateria.Account.Guardian do
  use Guardian, otp_app: :homer_salgateria

  alias HomerSalgateria.Account

  def subject_for_token(%{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Account.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
