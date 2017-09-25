defmodule TechTalks.Repo.Migrations.DefaultLikeValue do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      modify :likes, :integer, default: 1
    end
  end
end
