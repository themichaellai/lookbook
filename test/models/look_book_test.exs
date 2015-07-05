defmodule Lookbook.LookBookTest do
  use Lookbook.ModelCase

  alias Lookbook.LookBook

  @valid_attrs %{name: "some content", source_url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LookBook.changeset(%LookBook{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LookBook.changeset(%LookBook{}, @invalid_attrs)
    refute changeset.valid?
  end
end
