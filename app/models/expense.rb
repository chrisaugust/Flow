class Expense < ApplicationRecord

  belongs_to :category
  belongs_to :user

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true
  validates :description, length: { minimum: 3 }
  validates :category, presence: true
  
  def self.current_month
    Expense.find_by_sql(["SELECT * FROM expenses WHERE date > ?", Date.today.last_month.end_of_month])
  end

  def self.current_month_for(user_id)
    Expense.find_by_sql(["SELECT * FROM expenses WHERE date > ? AND user_id = ?", Date.today.last_month.end_of_month, user_id]) 
  end
end
