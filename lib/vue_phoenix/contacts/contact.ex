defmodule VuePhoenix.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  @derived [
    :id ,
    :address,
    :city,
    :country,
    :email,
    :first_name,
    :last_name,
    :phone,
    :postal_code,
    :region,
    :organization
   ]
  
   @derive {Jason.Encoder, only: @derived}

  #  @derive {Jason.Encoder, except: [:__meta__]}

  schema "contacts" do
    field :address, :string
    field :city, :string
    field :country, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :postal_code, :string
    field :region, :string

    belongs_to :organization, VuePhoenix.Organizations.Organization
    belongs_to :account, VuePhoenix.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:first_name, :last_name, :email, :country, :postal_code, :phone, :address, :city, :region, :organization_id])
    |> validate_required([:first_name, :last_name])
  end
end
