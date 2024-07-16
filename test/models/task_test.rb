require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @category = categories(:one) # Assuming you have fixture data for categories
    @task = tasks(:one) # Assuming you have fixture data for tasks
  end
  
  test "details should be present" do
    @task.details = nil
    assert_not @task.valid?
  end
end
