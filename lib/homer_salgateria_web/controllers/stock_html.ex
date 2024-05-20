defmodule HomerSalgateriaWeb.StockHTML do
  use HomerSalgateriaWeb, :html

  embed_templates "stock_html/*"

  @doc """
  Renders a stock form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :produtos, :list, required: true

  def stock_form(assigns)
end
