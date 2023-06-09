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

  def self.past_three_months_for(user_id)
    this_month = Date.today.strftime('%m-%Y')
    last_month = Date.today.prev_month.strftime('%m-%Y')
    previous_month = Date.today.prev_month.prev_month.strftime('%m-%Y')
    months = [this_month, last_month, previous_month]
  end

  def self.current_month_for(user_id)
    Expense.find_by_sql(["SELECT * FROM expenses WHERE date > ? AND user_id = ?", Date.today.last_month.end_of_month, user_id]) 
  end

  def self.expenses_for(month_year, user_id)
    month, year = month_year.split('-')
    month = month.to_i
    year = year.to_i
    first_day_of_month = Date.new(year, month, 1)
    last_day_of_month = first_day_of_month.next_month.prev_day
    Expense.find_by_sql(["SELECT * FROM expenses WHERE date >= ? AND date <= ? AND user_id = ?", first_day_of_month, last_day_of_month, user_id])
  end
end
