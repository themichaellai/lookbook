defmodule Lookbook.LookTest do
  use Lookbook.ModelCase

  alias Lookbook.Look

  @valid_attrs %{description: "some content", lookbook_id: 42, name: "some content", source_url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Look.changeset(%Look{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Look.changeset(%Look{}, @invalid_attrs)
    refute changeset.valid?
  end
end
