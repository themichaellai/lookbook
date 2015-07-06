defmodule Lookbook.LookBookController do
  use Lookbook.Web, :controller

  alias Lookbook.LookBook
  alias Scraper.Imgur

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
      lookbook = Repo.insert!(changeset)
      imgur_match = Regex.run(
        ~r/imgur.com\/a\/([a-zA-Z0-9]+)/,
        lookbook.source_url)
      case imgur_match do
        [_, album_id] ->
          Imgur.get_album(album_id)["data"]["images"]
          |> save_looks lookbook
        _ -> nil
      end

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

  defp save_looks(look_list, lookbook) do
    Enum.each look_list, fn(look_data) ->
      %Lookbook.Look{
        name: look_data["title"],
        description: look_data["description"],
        path: look_data["link"],
        source_url: look_data["link"],
        look_book_id: lookbook.id
      }
      |> Repo.insert!
    end
  end
end
