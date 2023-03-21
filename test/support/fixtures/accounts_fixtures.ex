defmodule VuePhoenix.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VuePhoenix.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> VuePhoenix.Accounts.create_account()

    account
  end
end
