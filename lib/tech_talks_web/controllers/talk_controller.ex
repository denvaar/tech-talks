defmodule TechTalksWeb.TalkController do
  use TechTalksWeb, :controller

  alias TechTalks.Talks
  alias TechTalks.Talks.Talk

  def index(conn, _params) do
    talks = Talks.list_talks()
    render(conn, "index.html", talks: talks)
  end

  def new(conn, _params) do
    changeset = Talks.change_talk(%Talk{})
    render(conn, "new.html",
      changeset: changeset,
      requested_topics: Talks.unused_requested_topics())
  end

  def create(conn, %{"talk" => talk_params}) do
    case Talks.create_talk(talk_params) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          requested_topics: Talks.unused_requested_topics())
    end
  end
end
