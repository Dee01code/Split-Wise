class ExpensesController < ApplicationController

  def index
    @expenses = Expense.all
  end
  def new
    @expense = Expense.new
    # @users = User.all
  end

  def create
    binding.break
    @expense = Expense.new(expense_params)
    if @expense.save
      split_ids = []

      params[:expense][:user_ids].each do |user_id|
        split_ids << user_id.to_i if user_id.present?
      end

      @expense.user_ids = split_ids

      binding.break 

      flash[:notice] = "Expense created successfully"
      redirect_to expenses_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def destroy
  end

  
  private
  def expense_params
    params.require(:expense).permit(:description, :type, :amount, :expense_type)
  end

end
