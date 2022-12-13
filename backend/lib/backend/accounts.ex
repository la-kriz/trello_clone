defmodule Backend.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Accounts.User
  alias Backend.Access.UserPermission

  def create_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_by_email(email) do
    query = from u in User, where: u.email == ^email
    
    case Repo.one(query) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def get_by_id!(id) do
    User
    |> Repo.get!(id)
  end

  def get_other_users(id) do
    users = from user in User,
      where: user.id != ^id
    Repo.all(users)
  end

  def authenticate_user(email, password) do
    with {:ok, user} <- get_by_email(email) do
      case validate_password(password, user.password) do
        false -> {:error, :unauthorized}
        true -> {:ok, user}
      end
    end
  end

  defp validate_password(password, encrypted_password) do
    Bcrypt.verify_pass(password, encrypted_password)
  end
end
