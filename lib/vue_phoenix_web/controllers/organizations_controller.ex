defmodule VuePhoenixWeb.OrganizationsController do
   use VuePhoenixWeb, :controller
   
   alias VuePhoenix.{Repo, Organizations, Contacts}
   import VuePhoenixWeb.Utils
   
   def index(conn, params) do
      
      page = Organizations.list_organizations |> Repo.paginate(params)
      
      render_inertia(conn, "Organizations/Index",
      props: %{
         organizations: %{
            data: page.entries,
            links: pagination_links(page, "/organizations")
         }
      }
      )
   end
   
   def new(conn, _params) do
      render_inertia(conn, "Organizations/Create")
   end

   def create(conn, params) do
      case Organizations.create_organization(params) do  
         {:ok, _} ->
            conn
            |> put_flash(:success, "Created Organization")
            |> redirect(to: Routes.organizations_path(conn, :index))

         {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_flash(:error, "Error Creating an Organization")
            |> put_session(:errors, errors_from_changeset(changeset))
            |> redirect(to: Routes.organizations_path(conn, :new))
      end
   end
   
   
   def edit(conn, %{"id" => id}) do
      organization = Organizations.get_organization!(id)
      
      render_inertia(conn, "Organizations/Edit",
      props: %{
         organization: %{
            id:  organization.id,
            name:  organization.name,
            email:  organization.email,
            phone:  organization.phone,
            address:  organization.address,
            city:  organization.city,
            region:  organization.region,
            country:  organization.country,
            postal_code:  organization.postal_code,
            contacts: Contacts.organization_contacts(id)
         }
      }
      )
   end

   def update(conn, %{"id" => id} = params) do
      organization = Organizations.get_organization!(id)

      case Organizations.update_organization(organization, params) do
         {:ok, _} ->
            conn 
            |> put_flash(:success, "You've update an organization")
            |> redirect(to: Routes.organizations_path(conn, :index))

         {:error, %Ecto.Changeset{}} ->
            conn
            |> put_flash(:error, "Error Updating an organization")
            |> redirect(to: Routes.organizations_path(conn, :edit, id))   
      end
   end

   def delete(conn, %{"id" => id}) do
      organization = Organizations.get_organization!(id);

      Organizations.delete_organization(organization);

      conn
      |> put_flash(:info, "YOu've deleted an organizations successfully")
      |> redirect(to: Routes.organizations_path(conn, :index))
   end
   
end