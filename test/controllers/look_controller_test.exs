defmodule Lookbook.LookControllerTest do
  use Lookbook.ConnCase

  alias Lookbook.Look
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, look_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    look = Repo.insert! %Look{}
    conn = get conn, look_path(conn, :show, look)
    assert json_response(conn, 200)["data"] == %{
      "id" => look.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, look_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, look_path(conn, :create), look: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Look, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, look_path(conn, :create), look: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    look = Repo.insert! %Look{}
    conn = put conn, look_path(conn, :update, look), look: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Look, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    look = Repo.insert! %Look{}
    conn = put conn, look_path(conn, :update, look), look: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    look = Repo.insert! %Look{}
    conn = delete conn, look_path(conn, :delete, look)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Look, look.id)
  end
end
