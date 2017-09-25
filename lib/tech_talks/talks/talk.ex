defmodule TechTalks.Talks.Talk do
  use Ecto.Schema
  import Ecto.Changeset
  alias TechTalks.Talks.Talk


  schema "talks" do
    field :date, :utc_datetime
    field :description, :string
    field :estimated_duration, :string
    field :presenter, :string
    field :topic, :string
    field :topic_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Talk{} = talk, attrs) do
    talk
    |> cast(attrs, [:topic, :presenter, :description, :date, :estimated_duration])
    |> validate_required([:topic, :presenter, :date, :estimated_duration])
  end
end
