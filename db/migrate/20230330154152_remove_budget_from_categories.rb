class RemoveBudgetFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :budget
  end
end
