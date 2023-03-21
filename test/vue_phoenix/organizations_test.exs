defmodule VuePhoenix.OrganizationsTest do
  use VuePhoenix.DataCase

  alias VuePhoenix.Organizations

  describe "organizations" do
    alias VuePhoenix.Organizations.Organization

    import VuePhoenix.OrganizationsFixtures

    @invalid_attrs %{address: nil, city: nil, email: nil, name: nil, phone: nil, region: nil}

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      valid_attrs = %{address: "some address", city: "some city", email: "some email", name: "some name", phone: "some phone", region: "some region"}

      assert {:ok, %Organization{} = organization} = Organizations.create_organization(valid_attrs)
      assert organization.address == "some address"
      assert organization.city == "some city"
      assert organization.email == "some email"
      assert organization.name == "some name"
      assert organization.phone == "some phone"
      assert organization.region == "some region"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      update_attrs = %{address: "some updated address", city: "some updated city", email: "some updated email", name: "some updated name", phone: "some updated phone", region: "some updated region"}

      assert {:ok, %Organization{} = organization} = Organizations.update_organization(organization, update_attrs)
      assert organization.address == "some updated address"
      assert organization.city == "some updated city"
      assert organization.email == "some updated email"
      assert organization.name == "some updated name"
      assert organization.phone == "some updated phone"
      assert organization.region == "some updated region"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Organizations.update_organization(organization, @invalid_attrs)
      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end
end
