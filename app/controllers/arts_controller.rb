class ArtsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_art, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @tags = Tag.all
    if params[:tag]
      tag = Tag.find(params[:tag].to_i)
      @arts = tag.arts.page(params[:page]).reverse_order
    elsif params[:sort] == "asc" #新着順
      @arts = Art.all.order(id: "ASC").page(params[:page]).reverse_order
    elsif params[:user_id]
      @arts = Art.where(user_id: current_user.id).page(params[:page]).reverse_order
    else
      @arts = Art.page(params[:page]).reverse_order
    end
  end

  def new
    @art = Art.new
  end

  def create
    @art = current_user.arts.new(art_params)
    if @art.save #同時にカレンダーに表示させる
      event = Event.new
      event.user_id = current_user.id
      event.title = @art.title
      event.detail = @art.detail
      event.event_type = 1 #イラスト投稿日
      event.art_id = @art.id
      event.start_date = @art.created_at
      event.end_date = @art.created_at
      event.save
      redirect_to art_path(@art)
    else
      render :new
    end
  end

  def show
    @user = @art.user
    @comment = Comment.new
    @cart_art = CartArt.new
    if user_signed_in?
      @events = Event.where(user_id: current_user.id)
    end
  end

  def update
    if @art.update(art_params)
      redirect_to art_path(@art)
    else
      render :edit
    end
  end

  def destroy
    event = Event.find_by(art_id: @art.id)
    if @art.destroy #同時にイベントを削除
      event.destroy
    end
    redirect_to arts_path
  end

  private
  def art_params
    params.require(:art).permit(:title, :detail, :image, { :tag_ids=> [] })
  end

  def set_art
    @art = Art.find(params[:id])
  end

  def correct_user #URL直打ち防止
    @art = Art.find(params[:id])
    if @art.user_id != current_user.id
      redirect_to art_path(@art)
    end
  end
end