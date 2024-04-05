class ExpensesController < ApplicationController
  # before_action :popup_display,only: [:create]
  #before_action :set_expense, only: [:show, :edit, :update, :destroy]
  # before_action :third_filter
  # before_action :first_filter, except: [:create]
  # before_action :second_filter, only: [:new, :create, :index]

  # GET /expenses
  # GET /expenses.json
  
  def new
    @expense = Expense.new
    # @users = User.all
  end

  def create
    # binding.break
    @expense = Expense.new(expense_params)
    @expense.paid_by = current_user.id
    @expense.expense_type = "Equal"

    friends_ids = params[:expense][:user_ids]

    if @expense.save
      group_size = friends_ids.length-1
      amount_per_head = (@expense.amount)/group_size.to_f
      sender = @expense.paid_by

      split_ids = []

      friends_ids.each do |user_id|
        receiver = user_id.to_i 
        if user_id.present?
          unless sender.equal?(receiver)
            # puts amount_per_head.class 
            # if Transaction.exists?(sender: sender, receiver: receiver)
            #   Transaction.where(sender: sender, receiver: receiver).update_all("amount = amount + #{amount_per_head}")
            # else
            #   Transaction.create(sender: sender, receiver: receiver, amount: amount_per_head) 
            # end
            @expense.transactions.create(sender: sender, receiver: receiver, amount: amount_per_head)
          end
          split_ids << user_id.to_i 
        end

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
    @transactions = @expense.transactions
    @payer_id = @expense.paid_by
    @payer_name = User.find(@payer_id).name
  end

  def index
    @expenses = current_user.expenses
    @lene_ka_array = Transaction.where(sender: current_user.id).pluck(:receiver,:amount)
    @dene_ka_array = Transaction.where(receiver: current_user.id).pluck(:sender, :amount)

    @lene_ka_record = array_to_hash @lene_ka_array 
    @dene_ka_record = array_to_hash @dene_ka_array

    @net_balance_record = {}

    @lene_ka_record.each do |key, value|
      if @dene_ka_record[key].present?
        @net_balance_record[key] = value - @dene_ka_record[key] 
      else 
        @net_balance_record[key] = value
      end
    end

    @dene_ka_record.each do |key, value|
      unless @net_balance_record[key].present?
        @net_balance_record[key] = -value
      end
    end

    @balance_ids = []
    @net_balance_record.each do|key,value|
      @balance_ids << key
    end

    @map_id_names = User.where(id: @balance_ids).pluck(:id, :name).to_h
    @result = {}

    @map_id_names.each do|id, name|
      @result[name] = @net_balance_record[id]
    end
    @result

  end

  def destroy
  end

  
  private
  def expense_params
    params.require(:expense).permit(:description, :amount) 
    # binding.break
    # params.require(:expense).permit(:description, :amount, :expense_type)  
  end

  def array_to_hash arr
    result = {}
    arr.each do |nest_array|
      key = nest_array[0]
      value = nest_array[1]
      if result.has_key?(key)
          result[key] += value 
      else
          result[key] = value
      end
    end
    result
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
