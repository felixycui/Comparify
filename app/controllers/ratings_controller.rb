class RatingsController < ApplicationController
  before_action :set_user
  before_action :set_rating, except: [:create]

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    rating = Rating.new(rating_params)
    @user.ratings << rating
    redirect_to "/users/#{@user.id}"
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    @rating.update(rating_params) ? (redirect_to "/users/#{@user.id}") : (render :edit)
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    redirect_to "/users/#{@user.id}"
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_rating
    @rating = Rating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rating_params
    params.require(:rating).permit(:value)
  end
end
