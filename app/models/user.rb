class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :expenses, dependent: :destroy
  has_many :categories, through: :expenses

  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
              uniqueness: { case_sensitive: false }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
