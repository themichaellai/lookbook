defmodule Lookbook.LookBookController do
  use Lookbook.Web, :controller

  alias Lookbook.LookBook

  plug :scrub_params, "look_book" when action in [:create, :update]

  def index(conn, _params) do
    lookbooks = Repo.all(LookBook)
    render(conn, "index.html", lookbooks: lookbooks)
  end

  def new(conn, _params) do
    changeset = LookBook.changeset(%LookBook{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"look_book" => look_book_params}) do
    changeset = LookBook.changeset(%LookBook{}, look_book_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "LookBook created successfully.")
      |> redirect(to: look_book_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    look_book = Repo.get!(LookBook, id)
    render(conn, "show.html", look_book: look_book)
  end

  def edit(conn, %{"id" => id}) do
    look_book = Repo.get!(LookBook, id)
    changeset = LookBook.changeset(look_book)
    render(conn, "edit.html", look_book: look_book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "look_book" => look_book_params}) do
    look_book = Repo.get!(LookBook, id)
    changeset = LookBook.changeset(look_book, look_book_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "LookBook updated successfully.")
      |> redirect(to: look_book_path(conn, :index))
    else
      render(conn, "edit.html", look_book: look_book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    look_book = Repo.get!(LookBook, id)
    Repo.delete!(look_book)

    conn
    |> put_flash(:info, "LookBook deleted successfully.")
    |> redirect(to: look_book_path(conn, :index))
  end
end
