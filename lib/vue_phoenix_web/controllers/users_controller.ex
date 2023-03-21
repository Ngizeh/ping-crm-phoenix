defmodule VuePhoenixWeb.UsersController do
   use VuePhoenixWeb, :controller
   import VuePhoenixWeb.Utils

   alias VuePhoenix.Accounts

   plug :isOwner when not action in [:edit]

   def index(conn, _params) do
      render_inertia(conn, "Users/Index", props: %{
         users: Accounts.list_users
      })
   end

   def new(conn, _params) do
      render_inertia(conn, "Users/Create")
   end


   def edit(conn, %{"id" => id}) do
   	  owns(conn, String.to_integer(id))
      user = Accounts.get_user!(id)
      render_inertia(conn, "Users/Edit", props: %{ user: user})
   end

   def create(conn, user_params) do
      case Accounts.register_user(user_params) do
         {:ok, _user} ->
            conn
            |> put_flash(:success, "Created user successfully.")
            |> redirect(to: Routes.users_path(conn, :index))

         {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_flash(:error, "Error updating the User")
            |> put_session(:errors, errors_from_changeset(changeset))
            |> redirect(to: Routes.users_path(conn, :new))
      end
   end

   def update(conn, %{"id" => id} = user_params) do
      user = Accounts.get_user!(id)

      case Accounts.update_user(user, user_params) do
         {:ok, _user} ->
            conn
            |> put_flash(:success, "Updated user successfully.")
            |> redirect(to: Routes.users_path(conn, :edit, id))

         {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_flash(:error, "Error updating the User")
            |> put_session(:errors, errors_from_changeset(changeset))
            |> redirect(to: Routes.users_path(conn, :edit, id))
      end
   end

   def delete(conn, %{"id" => id}) do
      user = Accounts.get_user!(id);

      case Accounts.delete_user(user) do
        {:ok, _user} ->
         conn
         |> put_flash(:info, "You've deleted a user successfully")
         |> redirect(to: Routes.users_path(conn, :index))

      {:error, _} ->
         conn
         |> put_flash(:error, "Error deleting user")
         |> redirect(to: Routes.users_path(conn, :edit, user.id))
      end
   end

    def isOwner(conn, _opts) do
	    if conn.assigns.current_user.owner do
	      conn
	    else
	      conn
	      |> put_flash(:error, "You are unauthorized to access this page")
	      |> redirect(to: "/")
	      |> halt()
	    end
  	end

  	def owns(conn, id) do
	    if conn.assigns.current_user.id == id do
	      conn
	    else
	      conn
	      |> put_flash(:error, "You are unauthorized to access this page")
	      |> redirect(to: "/")
	      |> halt()
	    end
  	end
end
