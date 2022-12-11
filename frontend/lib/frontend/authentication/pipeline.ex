defmodule Frontend.Guardian.AuthPipeline do
  @claims %{"typ" => "access"}

  use Guardian.Plug.Pipeline,
      otp_app: :frontend,
      module: Frontend.Guardian,
      error_handler: Frontend.Guardian.AuthErrorHandler

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: @claims
  plug(Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer")
  plug(Guardian.Plug.LoadResource, allow_blank: true)

end
