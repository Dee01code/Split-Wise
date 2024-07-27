class ApplicationController < ActionController::Base
    helper_method :current_user 
    before_action :authenticate_user
    
    # include ExpensesHelper
    
    def current_user 
        @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
    end

    def authenticate_user
        redirect_to new_session_path unless current_user.present?
    end

end
