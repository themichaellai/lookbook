defmodule Lookbook.Look do
  use Lookbook.Web, :model

  schema "looks" do
    field :name, :string
    field :source_url, :string
    field :path, :string
    field :description, :string

    belongs_to :look_book, Lookbook.LookBook

    timestamps
  end

  @required_fields ~w(look_book_id path)
  @optional_fields ~w(name description source_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
