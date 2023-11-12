class CategoriesController < ApplicationController
  
  before_action :require_signin, except: [:home]
  before_action :require_admin, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:home, :index, :current_month, :single_month]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  def home 
    render :home
  end

  def index
    @expenses = current_user ? current_user.expenses : Expense.all
    set_chart_data
  end

  def current_month
    @expenses = current_user ? 
      Expense.current_month_for(current_user) : 
      Expense.current_month
    set_chart_data
  end

  def past_months
    redirect_to new_session_url unless current_user
    @months = Expense.past_three_months_for(current_user)
  end

  def single_month
    month_year = params["format"]
    @month, @year = month_year.split('-')
    redirect_to new_session_url unless current_user
    @expenses = Expense.expenses_for(month_year, current_user)
    set_chart_data
  end

  def show
    @expenses = @category.expenses.order(date: :desc)
      .filter { |e| e.user == current_user }
    @total_spending = total(@expenses)
    @spending_by_date = @expenses.group_by(&:date)
      .transform_values { |expenses| expenses.sum(&:amount) }

    @chart_data = @spending_by_date
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, status: :see_other
  end

  private

    def category_params
      params.require(:category).
        permit(:name, :description)
    end

    def total(expense_records)
      expense_records.map { |record| record.amount }.reduce(:+) || 0
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end

    def set_chart_data
      @totals_by_category = @categories.each_with_object({}) { |cat, hash| hash[cat] = 0 }
      @expenses.each { |e| @totals_by_category[e.category] += e.amount }
      @total_spending = total(@expenses)
      @chart_data = @categories.map { |cat| cat.name }.zip(@totals_by_category.values)
    end
end
