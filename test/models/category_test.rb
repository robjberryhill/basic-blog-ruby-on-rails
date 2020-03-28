require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # This setup method runs before all test always.
  def setup
    # Defining the @category with a test category named sports.
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
    # Tests that there is a model and table for category.
    # Because the @category is being set to a new category. If a new category can be made then this test will return true.
    assert @category.valid?
  end

  test "name is present" do
    # Sets the @category name to empty.
    @category.name = " "
    # This assert_not is expecting a false return for a valid? category for name empty. If the valid? returns false then the test will pass.
    # If the name is infact empty then the valid? will return true and fail the test. Because we do not want an empty name.
    assert_not @category.valid?
  end

  test "name is unique" do
    # Save the current category.
    @category.save
    # Create a new category with the same name.
    category2 = Category.new(name: "sports")
    # We are asserting that category2 should not be valid? because we already have a category with that name.
    # If category2 is infact not valid? then the test will pass.
    assert_not category2.valid?
  end

  test "name is too long" do
    # category name is equal to 26 characters.
    @category.name = "a" * 26
    # We are asserting that the category is not 26 characters.
    # If category is infact not valid? then the test will pass.
    assert_not @category.valid?
  end

  test "name is too short" do
    # category name is equal to 2 characters.
    @category.name = "aa"
    # We are asserting that the category is not 2 characters.
    # If category is infact not valid? then the test will pass.
    assert_not @category.valid?
  end
end
