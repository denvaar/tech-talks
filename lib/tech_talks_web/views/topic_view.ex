defmodule TechTalksWeb.TopicView do
  use TechTalksWeb, :view

  def render("likes.json", %{likes: likes}) do
    likes
  end
end
