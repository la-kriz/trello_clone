defmodule Frontend.Api.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Frontend.Repo

  alias Frontend.Api.Accounts.User

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

end