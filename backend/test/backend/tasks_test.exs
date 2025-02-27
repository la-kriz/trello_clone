defmodule Backend.TasksTest do
  use Backend.DataCase

  alias Backend.Tasks

  describe "comments" do
    alias Backend.Tasks.Comment

    @valid_attrs %{content: "some content", task_id: 2}
    @update_attrs %{content: "some updated content", task_id: 2}
    @invalid_attrs %{content: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Enum.member? Tasks.list_comments(), comment
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Tasks.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Tasks.create_comment(@valid_attrs)
      assert comment.content == "some content"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Tasks.update_comment(comment, @update_attrs)
      assert comment.content == "some updated content"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_comment(comment, @invalid_attrs)
      assert comment == Tasks.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Tasks.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Tasks.change_comment(comment)
    end
  end
end
