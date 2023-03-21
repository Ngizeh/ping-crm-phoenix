defmodule VuePhoenixWeb.ReportsController do
   use VuePhoenixWeb, :controller

   def index(conn, _params) do
      render_inertia(conn, "Reports/Index")
   end
end