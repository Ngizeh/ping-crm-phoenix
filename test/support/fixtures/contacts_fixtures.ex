defmodule VuePhoenix.ContactsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VuePhoenix.Contacts` context.
  """

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        address: "some address",
        city: "some city",
        country: "some country",
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone: "some phone",
        postal_code: "some postal_code",
        region: "some region"
      })
      |> VuePhoenix.Contacts.create_contact()

    contact
  end
end
