defmodule VuePhoenixWeb.Plugs.InertiaShare do
   @moduledoc false
   def init(default), do: default
   alias VuePhoenix.Accounts.User
   alias VuePhoenix.Repo
   import Phoenix.Controller
   import Plug.Conn

   def call(conn, _) do
     conn
     |> InertiaPhoenix.share(:auth, build_auth_map(conn))
     |> InertiaPhoenix.share(:errors, errors_from_session(conn))
     |> InertiaPhoenix.share(:csrf_token, get_csrf_token())
     |> delete_session(:errors)
   end

   defp build_auth_map(conn) do
     case Repo.preload(conn.assigns.current_user, :account) do
       %User{} = current_user ->
         %{
           user: %{
             id: current_user.id,
             account: %{name: current_user.account.name},
             first_name: current_user.first_name,
             last_name: current_user.last_name,
             owner: current_user.owner,
             photo: current_user.photo_path
           },
         }
       _ ->
         %{}
     end
   end

   defp errors_from_session(conn) do
     errors = get_session(conn, :errors)

     if is_map(errors) and map_size(errors) > 0 do
       errors
     else
       %{}
     end
   end
 end
