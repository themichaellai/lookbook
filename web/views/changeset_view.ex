defmodule Lookbook.ChangesetView do
  use Lookbook.Web, :view

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: changeset}
  end

  def render("error.json", %{message: message}) do
    %{errors: message}
  end
end
