defmodule BackendWeb.CommentController do
  use BackendWeb, :controller

  alias Backend.Tasks
  alias Backend.Tasks.Comment

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    comments = Tasks.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Tasks.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Tasks.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Tasks.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Tasks.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Tasks.get_comment!(id)

    with {:ok, %Comment{}} <- Tasks.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
