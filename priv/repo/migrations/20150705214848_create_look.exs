defmodule Lookbook.Repo.Migrations.CreateLook do
  use Ecto.Migration

  def change do
    create table(:looks) do
      add :name, :string
      add :source_url, :string
      add :lookbook_id, :integer
      add :description, :string

      timestamps
    end

  end
end
