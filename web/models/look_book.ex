defmodule Lookbook.LookBook do
  use Lookbook.Web, :model

  schema "lookbooks" do
    field :name, :string
    field :source_url, :string

    has_many :looks, Lookbook.Look

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(source_url)

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
