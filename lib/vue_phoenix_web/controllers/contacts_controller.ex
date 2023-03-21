defmodule VuePhoenixWeb.ContactsController do
   use VuePhoenixWeb, :controller

   alias VuePhoenix.{Organizations, Contacts, Repo}
   import VuePhoenixWeb.Utils


   def index(conn, params) do
      page = Contacts.list_contacts |> Repo.paginate(params)

      render_inertia(conn, "Contacts/Index",
      props: %{
         contacts: %{
            data: page.entries,
            links: pagination_links(page, "/contacts"),
         },
         filters: %{role: "", search: "", trashed: ""}
      }
      )
   end

   def new(conn, _params) do
      render_inertia(conn, "Contacts/Create", props: %{ organizations: Organizations.list_organizations})
   end


   def create(conn, params) do
      case Contacts.create_contact(params) do
         {:ok, _} ->
         conn
         |> put_flash(:success, "Created a Contact")
         |> redirect(to: Routes.contacts_path(conn, :index))

         {:error, %Ecto.Changeset{} = changeset} ->
         conn
         |> put_flash(:error, "Error Creating a Contact")
         |> put_session(:errors, errors_from_changeset(changeset))
         |> redirect(to: Routes.contacts_path(conn, :new))
      end
   end


   def edit(conn, %{"id" => id}) do
      contact = Contacts.get_contact!(id)

      render_inertia(conn, "Contacts/Edit",
       props: %{
          contact: contact,
          organizations: Organizations.list_organizations
       }
      )
   end


   def update(conn, %{"id" => id} = params) do
      contact = Contacts.get_contact!(id)

      case Contacts.update_contact(contact, params) do
         {:ok, _} ->
         conn
         |> put_flash(:success, "Updated a Contact")
         |> redirect(to: Routes.contacts_path(conn, :index))

         {:error, %Ecto.Changeset{}} ->
         conn
         |> put_flash(:error, "Error Updating a Contact")
         |> redirect(to: Routes.contacts_path(conn, :edit, id))
      end
   end


   def delete(conn, %{"id" => id}) do
      contact = Contacts.get_contact!(id);

      Contacts.delete_contact(contact)

      conn
      |> put_flash(:info, "You've deleted a contact successfully")
      |> redirect(to: Routes.contacts_path(conn, :index))
   end
end
