defmodule Backend.Access do
  @moduledoc """
  The Access context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Access.UserPermission

  def get_permission_by_user(user_id) do
    query = from p in UserPermission, where: p.user_id == ^user_id

    case Repo.one(query) do
      nil -> {:error, :not_found}
      permission -> {:ok, permission}
    end
  end

  def set_permission_by_user_id(user_id, user_permission) do
    case Repo.get_by(UserPermission, user_id: user_id) do

      nil -> Repo.insert(UserPermission.changeset(%UserPermission{}, %{user_id: user_id, permission: user_permission}))

      existing_permission -> existing_permission
                             |> Ecto.Changeset.change(%{permission: user_permission})
                             |> Repo.update()
    end
  end

  def create_user_permission(attrs \\ %{}) do
    %UserPermission{}
    |> UserPermission.changeset(attrs)
    |> Repo.insert()
  end

end
