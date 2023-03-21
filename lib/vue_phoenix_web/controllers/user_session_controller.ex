defmodule VuePhoenixWeb.UserSessionController do
  use VuePhoenixWeb, :controller

  alias VuePhoenix.Accounts
  alias VuePhoenixWeb.UserAuth

  def new(conn, _params) do
    render_inertia(conn, "Auth/Login")
  end

  def create(conn, params) do
    %{"email" => email, "password" => password} = params

    if user = Accounts.get_user_by_email_and_password(email, password) do

      conn
      |> put_flash(:success, "Welcome back #{user.first_name} ")
      |> UserAuth.log_in_user(user, params)

    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> redirect(to: Routes.user_session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:success, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
