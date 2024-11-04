require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'should not save task if ERROR occurs' do
    task = Task.new
    expect(task.save).to be_falsey, "Saved the task without a name"
  end
end
