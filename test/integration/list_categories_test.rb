require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "books")
    @category2 = Category.create(name: "programming")
  end
  test "show category listing" do
    get categories_path
    assert_template "categories/index"
    # We are asserting that on this index page that the categories are links
    # and should link to the category path. and the text should be the name of the category.
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
