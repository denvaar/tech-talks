defmodule TechTalksWeb.LikesChannel do
  use TechTalksWeb, :channel

  def join("likes:*", payload, socket) do
    {:ok, socket}
  end

  def handle_out(event, payload, socket) do
    broadcast socket, event, payload
    {:noreply, socket}
  end

  def broadcast_change('like', topic) do
    TechTalksWeb.Endpoint.broadcast("likes:*", "like",
      %{"id" => topic.id, "likes" => topic.likes})
  end

  def broadcast_change('create', topic) do
    TechTalksWeb.Endpoint.broadcast("likes:*", "create",
      %{"id" => topic.id, "likes" => topic.likes, "name" => topic.name})
  end
end
