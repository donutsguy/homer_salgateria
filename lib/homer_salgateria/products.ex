defmodule HomerSalgateria.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias HomerSalgateria.Repo

  alias HomerSalgateria.Products.Supply

  @doc """
  Returns the list of supplies.

  ## Examples

      iex> list_supplies()
      [%Supply{}, ...]

  """
  def list_supplies do
    Repo.all(Supply)
  end

  @doc """
  Gets a single supply.

  Raises `Ecto.NoResultsError` if the Supply does not exist.

  ## Examples

      iex> get_supply!(123)
      %Supply{}

      iex> get_supply!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supply!(id), do: Repo.get!(Supply, id)

  @doc """
  Creates a supply.

  ## Examples

      iex> create_supply(%{field: value})
      {:ok, %Supply{}}

      iex> create_supply(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supply(attrs \\ %{}) do
    %Supply{}
    |> Supply.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supply.

  ## Examples

      iex> update_supply(supply, %{field: new_value})
      {:ok, %Supply{}}

      iex> update_supply(supply, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supply(%Supply{} = supply, attrs) do
    supply
    |> Supply.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a supply.

  ## Examples

      iex> delete_supply(supply)
      {:ok, %Supply{}}

      iex> delete_supply(supply)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supply(%Supply{} = supply) do
    Repo.delete(supply)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supply changes.

  ## Examples

      iex> change_supply(supply)
      %Ecto.Changeset{data: %Supply{}}

  """
  def change_supply(%Supply{} = supply, attrs \\ %{}) do
    Supply.changeset(supply, attrs)
  end

  @doc """
  Gets all products and ids and put on a list of tuples
  """
  def get_products_ids() do
    query =
      from s in Supply,
        select: {s.nome, s.id}

    Repo.all(query)
  end
end
