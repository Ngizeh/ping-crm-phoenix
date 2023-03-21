defmodule VuePhoenix.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset


 @derived [
  :id ,
  :address,
  :city,
  :email,
  :name,
  :phone,
  :region,
  :country,
  :postal_code,
 ]

 @derive {Jason.Encoder, only: @derived}

  schema "organizations" do
    field :address, :string
    field :city, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :region, :string
    field :country, :string
    field :postal_code, :string

    belongs_to :account, VuePhoenix.Accounts.Account
    
    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :email, :phone, :address, :city, :region, :country, :postal_code])
    |> validate_required([:name])
  end
end
