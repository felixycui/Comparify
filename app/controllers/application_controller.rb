class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method def logged_in?
    session[:user_id]
  end

  helper_method def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def authenticate_user
    redirect_to '/' unless logged_in?
  end
end
