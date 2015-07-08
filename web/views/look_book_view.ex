defmodule Lookbook.LookBookView do
  use Lookbook.Web, :view

  def render("index.json", %{lookbooks: lookbooks}) do
    %{data: render_many(lookbooks, "look_book.json")}
  end

  def render("show.json", %{look_book: look_book}) do
    %{data: render_one(look_book, "look_book.json")}
  end

  def render("look_book.json", %{look_book: look_book}) do
    %{
      id: look_book.id,
      name: look_book.name,
      source_url: look_book.source_url
    }
  end
end
