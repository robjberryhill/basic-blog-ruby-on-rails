require "test_helper"

# In rails 5 class CategoriesControllerTest < ActionDispatch::IntegrationTest
class CategoriesControllerTest < ActionController::TestCase
  def setup
    # setting the @category variable to create a new Category.
    # The create() method both creates and hits the db unlike new()
    # This variable is need to pass in the category to the show test.
    @category = Category.create(name: "sports")
  end
  test "get categories index" do
    # In rails 5 get categories_path. You have to path: instead of :index. use rails routes.
    get :index
    # We are asserting that the response we get from that route will be successful.
    # If infact it is then the test will pass.
    assert_response :success
  end

  test "get categories new" do
    # In rails 5 get new_category_path. You have to path: instead of :new. use rails routes.
    get :new
    # We are asserting that the response we get from that route will be successful.
    # If infact it is then the test will pass.
    assert_response :success
  end

  test "get categories show" do
    # In rails 5 pass in the @category object for IntegrationTest
    # instead of just the id for TestCase
    # In rails 5 get category_path. You have to path: instead of :show. use rails routes.
    get(:show, params: { id: @category.id })
    # We are asserting that the response we get from that route will be successful.
    # If infact it is then the test will pass.
    assert_response :success
  end
end
