defmodule TechTalks.Talks.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias TechTalks.Talks.Topic


  schema "topics" do
    field :description, :string
    field :name, :string
    field :likes, :integer, default: 1
    field :used, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:name, :description, :likes, :used])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
