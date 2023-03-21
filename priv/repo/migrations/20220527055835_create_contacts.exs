defmodule VuePhoenix.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :country, :string
      add :postal_code, :string
      add :phone, :string
      add :address, :string
      add :city, :string
      add :region, :string
      add :account_id, references(:accounts, on_delete: :delete_all)
      add :organization_id, references(:organizations, on_delete: :delete_all)

      timestamps()
    end

    create index(:contacts, [:account_id])
    create index(:contacts, [:organization_id])
  end
end
