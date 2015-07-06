defmodule Http.Imgur do
  use HTTPotion.Base

  def process_request_headers(headers) do
    client_id = Application.get_env(:lookbook, :imgur)[:client_id]
    Dict.put headers, :"Authorization", "Client-ID #{client_id}"
  end

  def process_response_body(body) do
    body
    |> to_string
    |> Poison.Parser.parse!
  end
end

defmodule Scraper.Imgur do
  def get_album(id) do
    Http.Imgur.get("https://api.imgur.com/3/album/#{id}").body
  end
end
