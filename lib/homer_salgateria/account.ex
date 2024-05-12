defmodule HomerSalgateria.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false

  alias HomerSalgateria.Repo

  alias HomerSalgateria.Account.User

  alias Argon2

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.validate_register(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.validate_register(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.validate_register(user, attrs)
  end

  def change_login(%User{} = user, attrs \\ %{}) do
    User.validate_login(user, attrs)
  end

  def change_req_reset_password(%User{} = user, attrs \\ %{}) do
    User.validate_req_reset_password(user, attrs)
  end

  def authenticate_user(username, plain_text_password) do
    query = from u in User, where: u.email == ^username

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.senha) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def deliver_reset_password_instructions(user) do
    
  end

  def get_user_email!(email), do: Repo.get!(User, email)
end
