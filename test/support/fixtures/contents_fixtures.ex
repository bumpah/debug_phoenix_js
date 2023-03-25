defmodule DebugPhoenixJs.ContentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DebugPhoenixJs.Contents` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> DebugPhoenixJs.Contents.create_article()

    article
  end
end
