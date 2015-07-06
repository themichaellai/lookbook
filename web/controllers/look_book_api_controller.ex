defmodule Lookbook.LookBookApiController do
  use Lookbook.Web, :controller

  alias Lookbook.LookBook
  alias Scraper.Imgur

  #plug :scrub_params, "look_book" when action in [:create, :update]

  def index(conn, _params) do
    lookbooks = Repo.all(LookBook) |> Repo.preload :looks
    render conn, "index.json", lookbooks: lookbooks
  end
end
