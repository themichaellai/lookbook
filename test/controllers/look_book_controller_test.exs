defmodule Lookbook.LookBookControllerTest do
  use Lookbook.ConnCase

  alias Lookbook.LookBook
  @valid_attrs %{name: "some content", source_url: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, look_book_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = get conn, look_book_path(conn, :show, look_book)
    assert json_response(conn, 200)["data"] == %{
      "id" => look_book.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, look_book_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, look_book_path(conn, :create), look_book: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(LookBook, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, look_book_path(conn, :create), look_book: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = put conn, look_book_path(conn, :update, look_book), look_book: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(LookBook, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = put conn, look_book_path(conn, :update, look_book), look_book: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = delete conn, look_book_path(conn, :delete, look_book)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(LookBook, look_book.id)
  end
end
