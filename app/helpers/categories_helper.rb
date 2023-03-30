module CategoriesHelper
  def show_as_percentage(category_total, grand_total)
    format('%.2f', 100*(category_total/grand_total)) 
  end
end
