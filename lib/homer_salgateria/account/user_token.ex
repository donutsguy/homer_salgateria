defmodule HomerSalgateria.Account.UserToken do
  use Ecto.Schema
  import Ecto.Query
  alias HomerSalgateria.Account.{UserToken, Guardian}

  @reset_password_validity_in_days 1

  schema "users_tokens" do
    field :token, :binary
    field :context, :string
    field :sent_to, :string
    belongs_to :user, HomerSalgateria.Account.User

    timestamps(updated_at: false)
  end

  def build_change_password_token(user, sent_to) do
    {:ok, token, _full_claims} = Guardian.encode_and_sign(user)

    {token,
     %UserToken{token: token, context: "reset_password", sent_to: sent_to, user_id: user.id}}
  end

  def verify_change_password_token_query(token, context) do
    from token in by_token_and_context_query(token, context),
      where: token.inserted_at > ago(@reset_password_validity_in_days, "day")
  end

  def verify_email_token_query(token, context) do
    days = days_for_context(context)

    from token in by_token_and_context_query(token, context),
      join: user in assoc(token, :user),
      where: token.inserted_at > ago(^days, "day") and token.sent_to == user.email,
      select: user
  end

  def by_token_and_context_query(token, context) do
    from UserToken, where: [token: ^token, context: ^context]
  end

  def by_user_and_contexts_query(user, :all) do
    from t in UserToken, where: t.user_id == ^user.id
  end

  def by_user_and_contexts_query(user, [_ | _] = contexts) do
    from t in UserToken, where: t.user_id == ^user.id and t.context in ^contexts
  end

  defp days_for_context("reset_password"), do: @reset_password_validity_in_days
end
