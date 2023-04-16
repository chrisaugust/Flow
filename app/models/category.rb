class Category < ApplicationRecord
  has_many :expenses, dependent: :destroy
  has_many :users, through: :expenses

  validates :name, presence: true, uniqueness: true
end
