defmodule Lookbook.LookBookController do
  use Lookbook.Web, :controller

  alias Lookbook.LookBook
  alias Scraper.Imgur

  plug :scrub_params, "look_book" when action in [:create, :update]

  def index(conn, _params) do
    lookbooks = Repo.all(LookBook)
    render(conn, "index.json", lookbooks: lookbooks)
  end

  def create(conn, look_book_params) do
    changeset = LookBook.changeset(%LookBook{}, look_book_params)

    if changeset.valid? do
      look_book = Repo.insert!(changeset)

      #imgur_match = Regex.run(
      #  ~r/imgur.com\/a\/([a-zA-Z0-9]+)/,
      #  look_book.source_url)
      #case imgur_match do
      #  [_, album_id] ->
      #    Imgur.get_album(album_id)["data"]["images"]
      #    |> save_looks look_book
      #  _ -> nil
      #end

      render(conn, "show.json", look_book: look_book)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Lookbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    look_book = Repo.get!(LookBook, id)
    render conn, "show.json", look_book: look_book
  end

  def update(conn, look_book_params) do
    look_book = Repo.get!(LookBook, look_book_params["id"])
    changeset = LookBook.changeset(look_book, look_book_params)

    if changeset.valid? do
      look_book = Repo.update!(changeset)
      render(conn, "show.json", look_book: look_book)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Lookbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    look_book = Repo.get!(LookBook, id)

    look_book = Repo.delete!(look_book)
    render(conn, "show.json", look_book: look_book)
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
