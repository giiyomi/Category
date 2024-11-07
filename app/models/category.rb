class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 255 }
  has_many :tasks
  belongs_to :user
end
