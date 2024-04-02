class ExpensesController < ApplicationController
  before_action :popup_display,only: [:create]
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

      flash[:alert] = 'New Expense successfully Added!'
      redirect_to expenses_path

    else
        # @expense.errors.full_messages.each do |message|
        #   flash[:alert] = message
        # end
        flash.now[:alert] = @expense.errors.full_messages.join(', ')
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
    params.require(:expense).permit(:description, :amount, :expense_type)
  end
  def popup_display
    flash[:alert] =  "Commiting the expense"
  end

end
