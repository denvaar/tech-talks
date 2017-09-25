defmodule TechTalks.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :topic, :string
      add :presenter, :string
      add :description, :text
      add :date, :utc_datetime
      add :estimated_duration, :string
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create index(:talks, [:topic_id])
  end
end
