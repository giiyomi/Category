require "test_helper"


class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)

    @task_one = tasks(:task_one)
    @task_two = tasks(:task_two)
    @task_three = tasks(:task_three)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should create category" do
    assert_difference("Category.count") do
      post categories_url, params: { category: { name: "Uniqueness", description: "Sample" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should get tasks for today" do
    get tasks_for_today_categories_url
    assert_response :success
    assert_not_nil assigns(:alltasks)
    assert_equal [@task_one, @task_three], assigns(:alltasks)
  end
end
