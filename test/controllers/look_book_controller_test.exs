defmodule Lookbook.LookBookControllerTest do
  use Lookbook.ConnCase

  alias Lookbook.LookBook
  @valid_attrs %{name: "some content", source_url: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, look_book_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing lookbooks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, look_book_path(conn, :new)
    assert html_response(conn, 200) =~ "New look_book"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, look_book_path(conn, :create), look_book: @valid_attrs
    assert redirected_to(conn) == look_book_path(conn, :index)
    assert Repo.get_by(LookBook, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, look_book_path(conn, :create), look_book: @invalid_attrs
    assert html_response(conn, 200) =~ "New look_book"
  end

  test "shows chosen resource", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = get conn, look_book_path(conn, :show, look_book)
    assert html_response(conn, 200) =~ "Show look_book"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, look_book_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = get conn, look_book_path(conn, :edit, look_book)
    assert html_response(conn, 200) =~ "Edit look_book"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = put conn, look_book_path(conn, :update, look_book), look_book: @valid_attrs
    assert redirected_to(conn) == look_book_path(conn, :index)
    assert Repo.get_by(LookBook, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = put conn, look_book_path(conn, :update, look_book), look_book: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit look_book"
  end

  test "deletes chosen resource", %{conn: conn} do
    look_book = Repo.insert! %LookBook{}
    conn = delete conn, look_book_path(conn, :delete, look_book)
    assert redirected_to(conn) == look_book_path(conn, :index)
    refute Repo.get(LookBook, look_book.id)
  end
end
