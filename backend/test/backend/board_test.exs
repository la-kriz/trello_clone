defmodule Backend.BoardTest do
  use Backend.DataCase

  alias Backend.Board

  describe "tasks" do
    alias Backend.Board.Task

    @valid_attrs %{assigned_person: "some assigned_person", description: "some description", title: "some title"}
    @update_attrs %{assigned_person: "some updated assigned_person", description: "some updated description", title: "some updated title"}
    @invalid_attrs %{assigned_person: nil, description: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Board.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Board.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Board.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Board.create_task(@valid_attrs)
      assert task.assigned_person == "some assigned_person"
      assert task.description == "some description"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Board.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Board.update_task(task, @update_attrs)
      assert task.assigned_person == "some updated assigned_person"
      assert task.description == "some updated description"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Board.update_task(task, @invalid_attrs)
      assert task == Board.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Board.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Board.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Board.change_task(task)
    end
  end

  describe "lists" do
    alias Backend.Board.List

    @valid_attrs %{position: 120.5, title: "some title"}
    @valid_attrs_with_empty_tasks %{position: 120.5, title: "some title", tasks: []}
    @update_attrs %{position: 456.7, title: "some updated title", tasks: []}
    @invalid_attrs %{position: nil, title: nil}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs_with_empty_tasks)
        |> Board.create_list()

      list
    end

    def list_fixture_with_tasks_not_loaded(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Board.create_list()

      list
    end

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Enum.member? Board.list_lists(), list
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture_with_tasks_not_loaded()
      assert Board.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      assert {:ok, %List{} = list} = Board.create_list(@valid_attrs)
      assert list.position == 120.5
      assert list.title == "some title"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Board.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, %List{} = list} = Board.update_list(list, @update_attrs)
      assert list.position == 456.7
      assert list.title == "some updated title"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture_with_tasks_not_loaded()
      assert {:error, %Ecto.Changeset{}} = Board.update_list(list, @invalid_attrs)
      assert list == Board.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture_with_tasks_not_loaded()
      assert {:ok, %List{}} = Board.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Board.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Board.change_list(list)
    end
  end
end
