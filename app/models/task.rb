class Task < ApplicationRecord
  validates :details, presence: true, uniqueness: true
  validates :due_date, presence: true
  belongs_to :category
end
