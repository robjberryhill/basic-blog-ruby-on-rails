require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "new form a create category" do
    # Will check if there is a path and method for new.
    # If there is then pass this stage of test.
    get new_category_path
    # add gem "rails-controller-testing" to the gemfile and bundle install to use this method.
    # We are asserting that there is a template for this method at categories/new.
    # If there is then pass this stage of test.
    assert_template "categories/new"
    # We are asserting that there should be a difference in the count of categories
    # by 1 after we do this action.
    assert_difference "Category.count", 1 do
      # The submission of a new form is handled by the create action.
      # Which is a http post request post_via_redirect. to the categories path.
      # Which is directed to the create action I mentioned above.
      # We need to pass in the category we are posting category: { name: "sports" }
      # post_via_redirect categories_path, category: { name: "sports" }
      # post_via_redirect is no longer available use the following.
      post categories_path, params: { category: { name: "sports" } }
      follow_redirect!
    end
    # We are asserting that after the post we will be directed here.
    assert_template "categories/index"
    # We need to ensure that the category name is displayed that was created.
    # We are asserting that the string sports will be displayed in the body html.
    assert_match "sports", response.body
  end
end
