require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @category = categories(:one)
    @task = tasks(:one)
  end
  
  test "details should be present" do
    @task.details = nil
    assert_not @task.valid?
  end

  test 'should not be valid with non-unique details' do
    Task.create(details: 'Sample Task', due_date: Date.today, category: @category)
    task = Task.new(details: 'Sample Task', due_date: Date.today, category: @category)
    assert_not task.valid?
    assert_includes task.errors[:details], 'has already been taken'
  end

  test 'should not be valid without a due_date' do
    task = Task.new(details: 'Sample Task', due_date: nil, category: @category)
    assert_not task.valid?
    assert_includes task.errors[:due_date], "can't be blank"
  end

end
