class User < ApplicationRecord
  has_many :expenses, dependent: :destroy
  has_many :categories, through: :expenses

  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
              uniqueness: { case_sensitive: false }
end
