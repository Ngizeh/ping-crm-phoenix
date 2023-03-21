defmodule VuePhoenix.OrganizationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VuePhoenix.Organizations` context.
  """

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        address: "some address",
        city: "some city",
        email: "some email",
        name: "some name",
        phone: "some phone",
        region: "some region"
      })
      |> VuePhoenix.Organizations.create_organization()

    organization
  end
end
