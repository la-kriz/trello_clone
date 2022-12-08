defmodule Frontend.Guardian do
  use Guardian, otp_app: :backend
  alias Frontend.Api.Accounts

  def subject_for_token(%{username: username}, _claims) do
    {:ok, "Username:#{username}"}
  end

  def subject_for_token(resource, _claims) do
    {:ok, resource.id}
  end

  def resource_from_claims(claims) do
    # find user from claims["sub"] or other information you stored inside claims
  end
end
