defmodule VuePhoenix.ContactsTest do
  use VuePhoenix.DataCase

  alias VuePhoenix.Contacts

  describe "contacts" do
    alias VuePhoenix.Contacts.Contact

    import VuePhoenix.ContactsFixtures

    @invalid_attrs %{address: nil, city: nil, country: nil, email: nil, first_name: nil, last_name: nil, phone: nil, postal_code: nil, region: nil}

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Contacts.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Contacts.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      valid_attrs = %{address: "some address", city: "some city", country: "some country", email: "some email", first_name: "some first_name", last_name: "some last_name", phone: "some phone", postal_code: "some postal_code", region: "some region"}

      assert {:ok, %Contact{} = contact} = Contacts.create_contact(valid_attrs)
      assert contact.address == "some address"
      assert contact.city == "some city"
      assert contact.country == "some country"
      assert contact.email == "some email"
      assert contact.first_name == "some first_name"
      assert contact.last_name == "some last_name"
      assert contact.phone == "some phone"
      assert contact.postal_code == "some postal_code"
      assert contact.region == "some region"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contacts.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      update_attrs = %{address: "some updated address", city: "some updated city", country: "some updated country", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", phone: "some updated phone", postal_code: "some updated postal_code", region: "some updated region"}

      assert {:ok, %Contact{} = contact} = Contacts.update_contact(contact, update_attrs)
      assert contact.address == "some updated address"
      assert contact.city == "some updated city"
      assert contact.country == "some updated country"
      assert contact.email == "some updated email"
      assert contact.first_name == "some updated first_name"
      assert contact.last_name == "some updated last_name"
      assert contact.phone == "some updated phone"
      assert contact.postal_code == "some updated postal_code"
      assert contact.region == "some updated region"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Contacts.update_contact(contact, @invalid_attrs)
      assert contact == Contacts.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Contacts.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Contacts.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Contacts.change_contact(contact)
    end
  end
end
