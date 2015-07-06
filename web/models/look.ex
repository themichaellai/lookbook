defmodule Lookbook.Look do
  use Lookbook.Web, :model

  schema "looks" do
    field :name, :string
    field :source_url, :string
    field :lookbook_id, :integer
    field :description, :string

    timestamps
  end

  @required_fields ~w(name source_url lookbook_id description)
  @optional_fields ~w()

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