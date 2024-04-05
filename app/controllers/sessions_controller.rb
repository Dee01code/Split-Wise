class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
    def new
      # if current_user.present? 
			# 	redirect_to root_path
			# end
      @user = User.new
    end
  
    def create
      # binding.break 
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to root_path 
      else
        flash[:alert] = "Invalid username or password"
        redirect_to new_session_path
      end
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end
    
  end
  