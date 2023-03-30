class AddUserColumnToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :user, foreign_key: true
  end
end
