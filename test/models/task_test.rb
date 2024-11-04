require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @category = Category.create!(name: 'Sample Category')
    @task = Task.create!(details: 'Existing Task', due_date: Date.today, category: @category)
  end

  describe 'validations' do
    it 'should not be valid without details' do
      @task.details = nil
      expect(@task).not_to be_valid
      expect(@task.errors[:details]).to include("can't be blank")
    end

    it 'should not be valid with non-unique details' do
      Task.create!(details: 'Sample Task', due_date: Date.today, category: @category)
      task = Task.new(details: 'Sample Task', due_date: Date.today, category: @category)
      expect(task).not_to be_valid
      expect(task.errors[:details]).to include('has already been taken')
    end

    it 'should not be valid without a due_date' do
      task = Task.new(details: 'Sample Task', due_date: nil, category: @category)
      expect(task).not_to be_valid
      expect(task.errors[:due_date]).to include("can't be blank")
    end
  end
end
