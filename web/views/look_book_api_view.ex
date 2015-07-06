defmodule Lookbook.LookBookApiView do
  use Lookbook.Web, :view

  alias Lookbook.LookApiView

  @attributes ~W(name source_url looks)

  def render("index.json", %{lookbooks: lookbooks}) do
    attrs = Enum.map(@attributes, &String.to_atom/1)
    lookbooks
    |> Stream.map(&(Map.take(&1, attrs)))
    |> Stream.map(&(
         Map.put(&1, :looks, LookApiView.render("index.json", looks: &1.looks))))
  end
end
