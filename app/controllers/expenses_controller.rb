class ExpensesController < ApplicationController
 
  def index
  end
 
  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @category = Category.find(params[:category_id])
    @expense = Expense.new
  end
  
  def create
    @category = Category.find(params[:category_id])
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end 
  end

  def edit
    @category = Category.find(params[:category_id])
    @expense = Expense.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to category_path(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to category_url(@category)
  end

  private

    def expense_params
      expense_params = params.require(:expense).
        permit(:amount, :date, :description, :category)
  
      category = Category.find_by(name: expense_params[:category])
      expense_params[:category] = category
      expense_params[:user] = User.find(session[:user_id])
      return expense_params
    end

end
