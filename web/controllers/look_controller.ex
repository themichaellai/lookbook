defmodule Lookbook.LookController do
  use Lookbook.Web, :controller

  alias Lookbook.Look

  #plug :scrub_params, "look" when action in [:create, :update]

  def index(conn, _params) do
    looks = Repo.all(Look)
    render(conn, "index.json", looks: looks)
  end

  def create(conn, look_params) do
    changeset = Look.changeset(%Look{}, look_params)

    if Map.has_key?(look_params, "photo") do
      %Plug.Upload{path: path, filename: filename} = look_params["photo"]
      File.cp!(path, "./uploads/#{filename}", fn _, _ -> true end)

      save_params = look_params
                    |> Map.delete("photo")
                    |> Map.put("path", "./uploads/#{filename}")
      changeset = Look.changeset(%Look{}, save_params)
      if changeset.valid? do
        look = Repo.insert!(changeset)
        render(conn, "show.json", look: look)
      else
        conn
        |> put_status(:unprocessable_entity)
        |> render(Lookbook.ChangesetView, "error.json", changeset: changeset)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Lookbook.ChangesetView, "error.json", message: "missing photo")
    end
  end

  def show(conn, %{"id" => id}) do
    look = Repo.get!(Look, id)
    render conn, "show.json", look: look
  end

  def update(conn, %{"id" => id, "look" => look_params}) do
    look = Repo.get!(Look, id)
    changeset = Look.changeset(look, look_params)

    if changeset.valid? do
      look = Repo.update!(changeset)
      render(conn, "show.json", look: look)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Lookbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    look = Repo.get!(Look, id)

    look = Repo.delete!(look)
    render(conn, "show.json", look: look)
  end
end
