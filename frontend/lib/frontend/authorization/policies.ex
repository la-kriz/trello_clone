defmodule Frontend.Policies do
  use PolicyWonk.Policy         # set up support for policies
  use PolicyWonk.Enforce        # turn this module into an enforcement plug

  @behaviour PolicyWonk.Policy

  @err_handler    MyApp.ErrorHandlers

  def policy( assigns, {:manage_and_write_allowed, perms} ) when is_list(perms) do
    supported_permissions = ["manage", "write"]
    case supported_permissions do
      nil -> {:error, "Unauthorized"}        # Fail. No permissions
      user_perms ->
        Enum.all?( perms, &(Enum.member?(user_perms, to_string(&1))) )
        |> case do
             true -> :ok                   # Success.
             false -> {:error, "Unauthorized"}  # Fail. Permission missing
           end
    end
  end

  def policy( assigns, {:manage_and_write_allowed, one_perm} ), do:
    policy( assigns, {:manage_and_write_allowed, [one_perm]} )

  def policy( assigns, {:manage_only_allowed, perm} ) do
    supported_permissions = "manage"
    case supported_permissions do
      nil -> {:error, "Unauthorized"}        # Fail. No permissions
      user_perm ->
        case user_perm === perm do
          true -> :ok                   # Success.
          false -> {:error, "Unauthorized"}  # Fail. Permission missing
        end
    end
  end

#  def policy_error(conn, error_data) when is_bitstring(error_data), do:
#    @err_handler.unauthorized(conn, error_data )
  def policy_error(conn, error_data), do: policy_error(conn, "Unauthorized" )

end
