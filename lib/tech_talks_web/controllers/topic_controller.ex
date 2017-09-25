defmodule TechTalksWeb.TopicController do
  use TechTalksWeb, :controller

  alias TechTalks.Talks
  alias TechTalks.Talks.Topic

  plug :assign_topics when action in [:create, :new]

  def index(conn, _params) do
    topics = Talks.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Talks.change_topic(%Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    case Talks.create_topic(topic_params) do
      {:ok, topic} ->
        TechTalksWeb.LikesChannel.broadcast_change('create', topic)
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def like_topic(conn, %{"id" => id}) do
    topic = Talks.get_topic!(id)

    case Talks.update_topic(topic, %{likes: topic.likes + 1}) do
      {:ok, topic} ->
        TechTalksWeb.LikesChannel.broadcast_change('like', topic)
        render(conn, "likes.json", likes: topic.likes)
      {:error, _} ->
        conn
        |> put_flash(:error, "Error liking this post.")
        render(conn, "likes.json", likes: topic.likes)
    end
  end

  defp assign_topics(conn, _params) do
    topics = Talks.list_topics()
    assign(conn, :topics, topics)
  end
end
