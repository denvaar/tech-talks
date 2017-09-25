defmodule TechTalks.Repo.Migrations.AddLikesToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :likes, :integer, null: true
    end
  end
end
