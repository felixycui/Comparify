class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show, :new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @tracks = Track.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to root_path unless @user == current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.set_percentage

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user == current_user && @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy if @user == current_user
    reset_session
    redirect_to users_path
  end

  def add_track
    track = Track.find(params[:track_id]) if params[:track_id].present?
    @user.tracks << track if (!@user.tracks.include? track) && track.present?
    redirect_to "/users/#{@user.id}"
  end

  def delete_track
    track = Track.find(params[:track_id])
    @user.tracks.delete(track)
    redirect_to "/users/#{@user.id}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password_hash)
  end

  def authenticate_user
    redirect_to '/' unless logged_in?
  end
end
