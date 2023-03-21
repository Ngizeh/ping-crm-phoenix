defmodule Ping.Accounts.UserSearch do
   
  @moduledoc """
  Search for users using filters.
  https://elixirschool.com/blog/ecto-query-composition/
  """

  alias VuePhoenix.Repo
  alias VuePhoenix.Accounts.User
  import Ecto.Query

  def search(criteria, admin_id) do
    base_query(admin_id)
    |> build_query(criteria)
    |> Repo.all()
  end

  defp base_query(admin_id) do
    from u in User,
      where: u.id != ^admin_id,
      select: [:id, :email, :photo, :first_name, :last_name, :owner, account: [:name]],
      preload: [:account]
  end

  defp build_query(query, {"page", _}) do
    where(query, [u], is_nil(u.trashed_at))
  end

  defp build_query(query, criteria) when map_size(criteria) == 0 do
    where(query, [u], is_nil(u.trashed_at))
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query(%{}, query) do
    query
    |> where([u], is_nil(u.trashed_at))
  end

  defp compose_query({"search", search}, query) do
    query
    |> where([u], is_nil(u.trashed_at))
    |> where(
      [u],
      ilike(u.first_name, ^"%#{search}%") or
        ilike(u.last_name, ^"%#{search}%") or
        ilike(u.email, ^"%#{search}%")
    )
  end

  defp compose_query({"role", "user"}, query) do
    query
    |> where([u], is_nil(u.trashed_at))
    |> where([u], u.owner == false)
  end

  defp compose_query({"role", "owner"}, query) do
    query
    |> where([u], is_nil(u.trashed_at))
    |> where([u], u.owner == true)
  end

  defp compose_query({"trashed", "with"}, query) do
    where(query, [u], is_nil(u.trashed_at) or not is_nil(u.trashed_at))
  end

  defp compose_query({"trashed", "only"}, query) do
    where(query, [u], not is_nil(u.trashed_at))
  end

  defp compose_query(_unsupported_param, query) do
    query
    |> where([u], is_nil(u.trashed_at))
  end
end
