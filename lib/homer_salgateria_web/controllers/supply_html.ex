defmodule HomerSalgateriaWeb.SupplyHTML do
  use HomerSalgateriaWeb, :html

  embed_templates "supply_html/*"

  @doc """
  Renders a supply form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def supply_form(assigns)
end
