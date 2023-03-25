defmodule DebugPhoenixJsWeb.FeatureTest do
  use DebugPhoenixJs.FeatureCase

  import Wallaby.Query

  @endpoint DebugPhoenixJsWeb.Endpoint

  setup do
    {:ok, _} = DebugPhoenixJs.Contents.create_article(%{title: "my title"})
    {:ok, _} = DebugPhoenixJs.Contents.create_article(%{title: "another one"})
    :ok
  end

  feature "Updates text content with JS using <.link patch />", %{session: session} do
    session
    |> visit("/")
    |> click(button("update query parameters"))
    |> assert_has(css("#current-query-params", text: "http://localhost:4002/?title=my+title"))
  end

  feature "Updates text content with JS using push_patch()", %{session: session} do
    session
    |> visit("/")
    |> fill_in(text_field("text-search"), with: "my title")
    |> assert_has(css("#current-query-params", text: "http://localhost:4002/?title=my+title"))
  end

  feature "Updates text content with both methods used together", %{session: session} do
    session
    |> visit("/")
    |> click(button("update query parameters"))
    |> assert_has(css("#current-query-params", text: "http://localhost:4002/?title=my+title"))
    |> fill_in(text_field("text-search"), with: "a")
    |> assert_has(css("#current-query-params", text: "http://localhost:4002/?title=a"))
  end
end
