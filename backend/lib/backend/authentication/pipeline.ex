defmodule Backend.Guardian.AuthPipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :backend,
    module: Backend.Guardian,
    error_handler: Backend.Guardian.AuthErrorHandler

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: @claims
  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, claims: @claims, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true

end
