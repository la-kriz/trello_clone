defmodule BackendWeb.UserView do
  use BackendWeb, :view
  alias BackendWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      password: user.password}
  end

  def render("user_list_for_sharing.json", %{users: users}) do
    %{data: render_many(users, UserView, "user_for_sharing.json")}
  end

  def render("user_for_sharing.json", %{user: user}) do
    %{id: user.id,
      email: user.email}
  end
end
