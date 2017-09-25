defmodule TechTalksWeb.PageController do
  use TechTalksWeb, :controller

  alias TechTalks.Talks

  def index(conn, _params) do
    talks = Talks.list_upcomming_talks()
    render(conn, "index.html", talks: talks)
  end
end
