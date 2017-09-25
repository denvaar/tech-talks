defmodule TechTalks.Repo.Migrations.UniqueTopicName do
  use Ecto.Migration

  def change do
    create unique_index(:topics, [:name])
  end
end
