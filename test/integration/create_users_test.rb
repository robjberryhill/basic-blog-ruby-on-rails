require "test_helper"

class CreateUsersTest < ActionDispatch::IntegrationTest
  test "new form a create user" do
    get signup_path
    assert_template "users/new"
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "LittleJohn", email: "little@john.com",
                                         password: "password", admin: false } }
      follow_redirect!
    end
    assert_template "users/show"
    assert_match "LittleJohn", response.body
  end

  test "invalid category failure" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "Category.count" do
      post users_path, params: { user: { username: " ", email: " ",
                                         password: " " } }
    end
    assert_template "users/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
