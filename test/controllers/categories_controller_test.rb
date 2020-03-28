require "test_helper"

# In rails 5 class CategoriesControllerTest < ActionDispatch::IntegrationTest
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    # setting the @category variable to create a new Category.
    # The create() method both creates and hits the db unlike new()
    # This variable is need to pass in the category to the show test.
    @category = Category.create(name: "sports")
    # Here we are creating an admin user to login in to the get new because it is admin restricted.
    @user = User.create(username: "LittleJohn", email: "little@john.com",
                        password: "password", admin: true)
  end
  test "get categories index" do
    # In rails 5 get categories_path. You have to path: instead of :index. use rails routes.
    get categories_path
    # We are asserting that the response we get from that route will be successful.
    # If infact it is then the test will pass.
    assert_response :success
  end

  test "get categories new" do
    # We are signing in the admin user here with a helper method from test_helper.
    sign_in_as(@user, "password")
    # In rails 5 get new_category_path. You have to path: instead of :new. use rails routes.
    get new_category_path
    # We are asserting that the response we get from that route will be successful.
    # If infact it is then the test will pass.
    assert_response :success
  end

  test "get categories show" do
    # In rails 5 pass in the @category object for IntegrationTest
    # instead of just the id for TestCase
    # In rails 5 get category_path. You have to path: instead of :show. use rails routes.
    get category_path(@category.id)
    # We are asserting that the response we get from that route will be successful.
    # If infact it is then the test will pass.
    assert_response :success
  end

  test "admin not login in redirect" do
    # We do not have a user logged in so.
    # We are asserting there will be no difference in the count of Category
    # and the user will be redirected to the categories_path
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "sports" } }
    end
    assert_redirected_to categories_path
  end
end
