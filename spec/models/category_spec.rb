require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'should not save category without a name' do
      category = Category.new
      expect(category.save).to be_falsey, "Saved the category without a name"
    end

    it 'should save category with a unique name' do
      Category.create(name: 'Unique Category')
      category = Category.new(name: 'Unique Category')
      expect(category.save).to be_falsey, "Could not save the category with a unique name"
    end
  end
end
