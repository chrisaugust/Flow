class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.date :date
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
