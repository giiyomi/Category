require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @category = categories(:one)
    @task = tasks(:one)
  end
  
  test "should get index" do
    get category_tasks_path(@category)
    assert_response :success
  end

  test "should get new" do
    get new_category_task_path(@category)
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post category_tasks_path(@category), params: { task: { details: "New Task", category_id: @category.id } }
    end

    assert_redirected_to category_tasks_path(@category)
  end

  test "should get edit" do
    assert_not_nil @category, "Category should not be nil"
    assert_not_nil @task, "Task should not be nil"
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete category_task_url(@category, @task)
    end

    assert_redirected_to category_tasks_path(@category)
    assert_equal 'Task was successfully deleted.', flash[:notice]
  end


end
