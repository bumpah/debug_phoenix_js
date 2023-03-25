defmodule DebugPhoenixJsWeb.ArticleLive.Index do
  use DebugPhoenixJsWeb, :live_view

  alias DebugPhoenixJs.Contents
  alias DebugPhoenixJs.Contents.Article

  @impl true
  def mount(_params, _session, socket) do
    changeset = Ecto.Changeset.change(%Article{title: ""})

    {:ok,
     socket
     |> assign(:articles, Contents.list_articles(%{}))
     |> assign(:form, Phoenix.Component.to_form(changeset))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    IO.inspect(params, label: "params")

    {:noreply,
     socket
     |> apply_action(socket.assigns.live_action, params)
     |> assign(:articles, Contents.list_articles(params))}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Article")
    |> assign(:article, Contents.get_article!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article")
    |> assign(:article, %Article{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  @impl true
  def handle_info({DebugPhoenixJsWeb.ArticleLive.FormComponent, {:saved, article}}, socket) do
    {:noreply, stream_insert(socket, :articles, article)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    article = Contents.get_article!(id)
    {:ok, _} = Contents.delete_article(article)

    {:noreply, stream_delete(socket, :articles, article)}
  end

  def handle_event("validate", %{"article" => %{"title" => title}}, socket) do
    {:noreply, push_patch(socket, to: ~p"/?title=#{title}")}
  end
end
