require "test_helper"

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "LittleJohn", email: "john@little.com",
                        password: "password", admin: true)
  end
  test "new form a create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "ArticleTitle",
                                               description: "Description for article." } }
      follow_redirect!
    end
    assert_template "articles/show"
    assert_match "ArticleTitle", response.body
  end

  test "invalid category failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: " ", description: " " } }
    end
    assert_template "articles/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
