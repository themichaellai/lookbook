defmodule Lookbook.LookView do
  use Lookbook.Web, :view

  def render("index.json", %{looks: looks}) do
    %{data: render_many(looks, "look.json")}
  end

  def render("show.json", %{look: look}) do
    %{data: render_one(look, "look.json")}
  end

  def render("look.json", %{look: look}) do
    %{id: look.id}
  end
end
