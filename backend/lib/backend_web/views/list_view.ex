defmodule BackendWeb.ListView do
  use BackendWeb, :view
  alias BackendWeb.ListView

  def render("index.json", %{lists: lists}) do
    %{data: render_many(lists, ListView, "list.json")}
  end

  def render("show.json", %{list: list}) do
    %{data: render_one(list, ListView, "list.json")}
  end

  def render("list.json", %{list: list}) do
    %{id: list.id,
      title: list.title,
      position: list.position,
      tasks: list.tasks
    }
  end
end
