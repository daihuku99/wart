class ArtsController < ApplicationController
  before_action :set_art, only: [:show, :edit, :update, :destroy]
  def index
    @arts = Art.all
  end

  def new
    @art = Art.new
  end

  def create
    @art = current_user.arts.new(art_params)
    @art.save
    redirect_to art_path(@art)
  end

  def show
    @user = @art.user
    @comment = Comment.new
    @cart_art = CartArt.new
    @events = Event.where(user_id: current_user.id)
  end

  def edit
  end

  def update
    @art.update(art_params)
    redirect_to art_path(@art)
  end

  def destroy
    @art.destroy
    redirect_to arts_path
  end

  private
  def art_params
    params.require(:art).permit(:title, :detail, :image, { :tag_ids=> [] })
  end

  def set_art
    @art = Art.find(params[:id])
  end

end
