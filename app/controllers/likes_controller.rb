class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @art = Art.find(params[:art_id])
    like = current_user.likes.new(art_id: @art.id)
    if @art.likes.where(user_id: current_user.id).exists?
      redirect_to arts_path
    else
      like.save
    end
  end

  def destroy
    @art = Art.find(params[:art_id])
    like = current_user.likes.find_by(art_id: @art.id)
    like.destroy
  end
end
