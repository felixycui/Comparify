class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    if !@user.nil? && @user.password_hash == params[:password_hash]
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
