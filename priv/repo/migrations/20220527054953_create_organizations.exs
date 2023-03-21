defmodule VuePhoenix.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :address, :string
      add :city, :string
      add :region, :string
      add :country, :string
      add :postal_code, :string
      add :account_id, references(:accounts, on_delete: :delete_all)

      timestamps()
    end

    create index(:organizations, [:account_id])
  end
end
