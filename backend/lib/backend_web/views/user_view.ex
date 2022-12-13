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

  def render("user_list_with_permission.json", %{users: users}) do
    %{data: render_many(users, UserView, "user_with_permission.json")}
  end

  def render("user_with_permission.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      permission: user.permission}
  end
end
