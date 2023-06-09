class CategoriesController < ApplicationController
  
  before_action :require_signin, except: [:home]
  before_action :require_admin, only: [:edit, :update, :destroy]

  def home 
    @expenses = Expense.all

    @categories = Category.all

    @totals_by_category = @categories.each_with_object({}) { |cat, hash| hash[cat] = 0 }
    @expenses.each { |e| @totals_by_category[e.category] += e.amount }

    @total_spending = total(@expenses)

    @chart_data = @categories.map { |cat| cat.name }.zip(@totals_by_category.values)   

    render :home
  end

  def index
    if current_user 
      @expenses = current_user.expenses
    else
      @expenses = Expense.all
    end

    @categories = current_user.categories.uniq

    @totals_by_category = @categories.each_with_object({}) { |cat, hash| hash[cat] = 0 }
    @expenses.each { |e| @totals_by_category[e.category] += e.amount }

    @total_spending = total(@expenses)

    @chart_data = @categories.map { |cat| cat.name }.zip(@totals_by_category.values)   
  end

  def current_month
    if current_user 
      @expenses = Expense.current_month_for(current_user)
      @categories = current_user.categories.uniq
    else
      @expenses = Expense.current_month
      @categories = Category.all
    end 

    @totals_by_category = @categories.each_with_object({}) { |cat, hash| hash[cat] = 0 } 
    @expenses.each { |e| @totals_by_category[e.category] += e.amount }

    @total_spending = total(@expenses)

    @chart_data = @categories.map { |cat| cat.name }.zip(@totals_by_category.values)   
  end

  def past_months
    if current_user
      @months = Expense.past_three_months_for(current_user)
    else
      redirect_to new_session_url
    end
  end

  def single_month
    month_year = params["format"]
    @month, @year = month_year.split('-')

    if current_user 
      @expenses = Expense.expenses_for(month_year, current_user)
      @categories = current_user.categories.uniq
    else
      redirect_to new_session_url
    end 

    @totals_by_category = @categories.each_with_object({}) { |cat, hash| hash[cat] = 0 } 
    @expenses.each { |e| @totals_by_category[e.category] += e.amount }

    @total_spending = total(@expenses)

    @chart_data = @categories.map { |cat| cat.name }.zip(@totals_by_category.values)   
  end

  def show
    @category = Category.find(params[:id])

    if current_user
      @expenses = @category.expenses.order(:date).filter { |e| e.user == current_user }
    else
      @expenses = @category.expenses.order(:date)
    end

    @total_spending = total(@expenses)

    @spending_by_date = @expenses.group_by(&:date).
      transform_values { |expenses| expenses.sum(&:amount) }

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
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id]) 
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

end
