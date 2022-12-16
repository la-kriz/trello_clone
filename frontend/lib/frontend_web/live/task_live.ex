defmodule FrontendWeb.TaskLive do
  use Phoenix.LiveView

  alias Decimal, as: D

  alias FrontendWeb.ApiClient.ListApiClient
  alias FrontendWeb.ApiClient.TaskApiClient
  alias FrontendWeb.ApiClient.PermissionApiClient
  alias FrontendWeb.ApiClient.UserApiClient
  alias FrontendWeb.ApiClient.CommentApiClient

  def mount(_params,
        %{"user_id" => user_id,
          "username" => username,
          "access_token" => access_token,
          "permission" => permission,
          "board_id" => board_id,
          "_csrf_token" => _},
        socket) do

    lists = ListApiClient.get_lists_by_current_board(%{"access_token" => access_token, "board_id" => board_id})

    socket = case lists do
      nil -> assign(socket, lists: [])
      _ -> data = lists
           assign(socket, lists: data)
    end

    socket = assign(socket, token: Phoenix.Controller.get_csrf_token())
    socket = assign(socket, user_id: user_id)
    socket = assign(socket, username: username)
    socket = assign(socket, access_token: access_token)
    socket = assign(socket, permission: permission)
    socket = assign(socket, board_id: board_id)

    {:ok, socket}
  end

  def render(assigns) do
    FrontendWeb.TaskView.render("index.html", assigns)
  end

  def handle_event("edit_list_title", %{"list_id" => list_id, "new_title" => new_title_param}, socket) do

    access_token = socket.assigns.access_token

    list_params = %{"title" => new_title_param}

    ListApiClient.update_list(%{"list_id" => list_id, "params" => list_params, "access_token" => access_token})

    {:noreply, socket}
  end

  def handle_event("send_comment", %{"comment_content" => comment_content, "task_id" => task_id}, socket) do

    comment_params = %{"content" => comment_content, "task_id" => task_id}

    access_token = socket.assigns.access_token

    CommentApiClient.add_comment_to_task(%{"comment_params" => comment_params, "access_token" => access_token})

    {:noreply, socket}
  end

  def handle_event("fetch_comments_of_task", %{"task_id" => task_id}, socket) do

    access_token = socket.assigns.access_token

    comments = CommentApiClient.get_comments_of_task(%{"task_id" => task_id, "access_token" => access_token})

    {:reply, %{"comments" => comments}, socket}
  end

  def handle_event("fetch_usernames_and_id_except_current_user", %{"current_user_id" => current_user_id}, socket) do

    other_users = UserApiClient.get_other_users(%{"current_user_id" => current_user_id})

    {:reply, %{"users" => other_users}, socket}
  end

  def handle_event("share_to_users", %{"users" => user_params}, socket) do

    IO.inspect user_params, label: ">>>>>>>>> user_params"

    board_id = socket.assigns.board_id

    PermissionApiClient.share_to_users(%{"users" => user_params, "board_id" => board_id})

    {:reply, %{}, socket}
  end

  def handle_event("reorder_task", %{
    "list_id" => list_id,
    "current_task_id" => current_task_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) when is_nil(before_task_position) and is_nil(after_task_position) do

    new_position_param = D.new(:os.system_time(:millisecond))

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}

    access_token = socket.assigns.access_token

    TaskApiClient.update_task(%{"list_id" => list_id, "id" => current_task_id, "task" => task_params, "access_token" => access_token})

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_task", %{
    "list_id" => list_id,
    "current_task_id" => current_task_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) when is_nil(before_task_position) do

    new_position_param = D.sub(after_task_position, D.new(50))

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}

    access_token = socket.assigns.access_token

    TaskApiClient.update_task(%{"list_id" => list_id, "id" => current_task_id, "task" => task_params, "access_token" => access_token})

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_task", %{
    "list_id" => list_id,
    "current_task_id" => current_task_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) when is_nil(after_task_position) do

    new_position_param = D.add(before_task_position, D.new(50))

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}

    access_token = socket.assigns.access_token

    TaskApiClient.update_task(%{"list_id" => list_id, "id" => current_task_id, "task" => task_params, "access_token" => access_token})

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_task", %{
    "list_id" => list_id,
    "current_task_id" => current_task_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) do

    before_task_position = D.new(before_task_position)
    after_task_position = D.new(after_task_position)

    new_position_param = D.div(D.add(before_task_position, after_task_position), 2)

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}

    access_token = socket.assigns.access_token

    TaskApiClient.update_task(%{"list_id" => list_id, "id" => current_task_id, "task" => task_params, "access_token" => access_token})

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_list", %{
    "list_id" => list_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket)  when is_nil(before_task_position) do

    new_position_param = D.sub(after_task_position, D.new(50))

    list_params = %{"position" => D.to_string(new_position_param)}

    IO.puts ">------------->>>>> called moving LIST at the left-most, new/after position is "
        <> ", " <> D.to_string(new_position_param) <> ", " <> after_task_position

    access_token = socket.assigns.access_token

    ListApiClient.update_list(%{"list_id" => list_id, "params" => list_params, "access_token" => access_token})

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_list", %{
    "list_id" => list_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position
  }, socket) do

    new_position_param = D.add(before_task_position, D.new(50))

    list_params = %{"position" => D.to_string(new_position_param)}

    IO.puts ">------------->>>>> called moving LIST at the right-most, before/new position is " <> before_task_position
            <> ", " <> D.to_string(new_position_param)

    access_token = socket.assigns.access_token

    ListApiClient.update_list(%{"list_id" => list_id, "params" => list_params, "access_token" => access_token})

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_list", %{
    "list_id" => list_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) do

    before_task_position = D.new(before_task_position)
    after_task_position = D.new(after_task_position)

    new_position_param = D.div(D.add(before_task_position, after_task_position), 2)

    list_params = %{"position" => D.to_string(new_position_param)}

    IO.puts ">------------->>>>> called moving LIST at the middle, before/new/after position is " <> D.to_string(before_task_position)
            <> ", " <> D.to_string(new_position_param) <> ", "<> D.to_string(after_task_position)

    access_token = socket.assigns.access_token

    ListApiClient.update_list(%{"list_id" => list_id, "params" => list_params, "access_token" => access_token})

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

end