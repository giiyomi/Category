require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end



  test "should get index" do
    get categories_url
    assert_response :success
  end



end
