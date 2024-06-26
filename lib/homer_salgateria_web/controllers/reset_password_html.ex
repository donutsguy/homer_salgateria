defmodule HomerSalgateriaWeb.ResetPasswordHTML do
  use HomerSalgateriaWeb, :html

  embed_templates "reset_password_html/*"

  @doc """
  Renders a user form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def user_form(assigns)
end
