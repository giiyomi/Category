require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save category without a name" do
    category = Category.new
    assert_not category.save, "Saved the category without a name"
  end

  test "should save category with a unique name" do
    category = Category.new(name: "Unique Category")
    assert category.save, "Could not save the category with a unique name"
  end


end
