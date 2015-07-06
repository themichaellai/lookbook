defmodule Lookbook.LookApiView do
  use Lookbook.Web, :view

  @attributes ~w(name description source_url path)

  def render("index.json", %{looks: looks}) do
    attrs = Enum.map(@attributes, &String.to_atom/1)
    looks
    |> Stream.map(&(Map.take(&1, attrs)))
  end
end
