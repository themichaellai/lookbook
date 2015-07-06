defmodule Lookbook.Repo.Migrations.CreateLook do
  use Ecto.Migration

  def change do
    create table(:looks) do
      add :name, :string
      add :source_url, :string
      add :path, :string
      add :look_book_id, :integer
      add :description, :string

      timestamps
    end

  end
end
