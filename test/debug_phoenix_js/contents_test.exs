defmodule DebugPhoenixJs.ContentsTest do
  use DebugPhoenixJs.DataCase

  alias DebugPhoenixJs.Contents

  describe "articles" do
    alias DebugPhoenixJs.Contents.Article

    import DebugPhoenixJs.ContentsFixtures

    @invalid_attrs %{title: nil}

    test "list_articles/1 returns all articles" do
      article = article_fixture()
      assert Contents.list_articles(%{}) == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Contents.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Article{} = article} = Contents.create_article(valid_attrs)
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contents.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Article{} = article} = Contents.update_article(article, update_attrs)
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Contents.update_article(article, @invalid_attrs)
      assert article == Contents.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Contents.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Contents.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Contents.change_article(article)
    end
  end
end
