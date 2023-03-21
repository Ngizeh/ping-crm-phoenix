defmodule VuePhoenixWeb.DashboardController do
  use VuePhoenixWeb, :controller

  def index(conn, _params) do
    render_inertia(conn, "Dashboard/Index")
  end

  def about(conn, _params) do
    render_inertia(conn, "Page/About")
  end

  def services(conn, _params) do
    render_inertia(conn, "Page/Services")
  end
end
