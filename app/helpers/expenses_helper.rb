module ExpensesHelper
  def category_names
    Category.all.map { |cat| cat.name }
  end
end
