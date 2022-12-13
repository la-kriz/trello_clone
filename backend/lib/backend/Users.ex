defmodule Backend.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.User.UserPermission

  def get_permission_by_user(user_id) do
    query = from p in UserPermission, where: p.user_id == ^user_id

    case Repo.one(query) do
      nil -> {:error, :not_found}
      permission -> {:ok, permission}
    end
  end

end
