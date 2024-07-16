class Task < ApplicationRecord
  validates :details, presence: true, uniqueness: true
  belongs_to :category

end
