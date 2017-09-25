defmodule TechTalks.Repo.Migrations.AddUsedFieldToTopic do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :used, :boolean, default: false, null: false
    end
  end
end
