class ExpensesController < ApplicationController
  # before_action :popup_display,only: [:create]
  #before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :third_filter
  before_action :first_filter, except: [:create]
  before_action :second_filter, only: [:new, :create, :index]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
  end
  def new
    @expense = Expense.new
    # @users = User.all
  end

  def create
    # binding.break
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
      @expense.errors.full_messages.each do |message|
        puts message
      end
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
    # binding.break
    params.require(:expense).permit(:description, :amount, :expense_type)  
  end

  def first_filter
    puts "Calling from first filter"
    Rails.logger.info "Calling from first filter"
  end

  def second_filter
    puts "Calling from second filter"
    Rails.logger.info "Calling from Second filter"
  end

  def third_filter
    puts "Calling from Third filter"
    Rails.logger.info "Calling from third filter"
  end

end
