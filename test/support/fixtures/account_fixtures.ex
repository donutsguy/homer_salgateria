defmodule HomerSalgateria.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HomerSalgateria.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        cpf: "some cpf",
        data_nascimento: ~D[2024-05-03],
        email: "some email",
        funcao: "some funcao",
        nome: "some nome",
        numero_telefone: "some numero_telefone",
        senha: "some senha"
      })
      |> HomerSalgateria.Account.create_user()

    user
  end
end
