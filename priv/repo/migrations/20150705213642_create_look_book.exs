defmodule Lookbook.Repo.Migrations.CreateLookBook do
  use Ecto.Migration

  def change do
    create table(:lookbooks) do
      add :name, :string
      add :source_url, :string, null: true

      timestamps
    end

  end
end
