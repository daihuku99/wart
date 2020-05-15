class ExhibitionsController < ApplicationController
  require 'date'
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_exhibition, only: [:show, :edit, :destroy, :update]
  def index
    @exhibitions = Exhibition.all
  end

  def new
    @exhibition = Exhibition.new
    @cart_arts = CartArt.where(user_id: current_user.id)
  end

  def create
    exhibition = current_user.exhibitions.new(exhibition_params)
    if exhibition.save
      current_user.cart_arts.each do |cart_art|
        exhibition_art = exhibition.exhibition_arts.new(art_id: cart_art.art.id)
        exhibition_art.save
      end
      event = Event.new
      event.user_id = current_user.id
      event.title = exhibition.title
      event.detail = exhibition.detail
      event.event_type = 2
      event.exhibition_id = exhibition.id
      event.start_date = exhibition.start_date
      event.end_date = exhibition.end_date
      event.save
      current_user.cart_arts.destroy_all
      redirect_to thanks_path(exhibition)
    end
  end

  def show
    @exhibition = Exhibition.find(params[:id])
    @comment = Comment.new
  end

  def update
    @exhibition.update(exhibition_params)
    redirect_to exhibition_path(@exhibition)
  end

  def destroy
    event = Event.find_by(exhibition_id: @exhibition.id)
    if @exhibition.destroy
      event.destroy
    end
    redirect_to exhibitions_path
  end

  private
  def exhibition_params
    params.require(:exhibition).permit(:title, :detail, :start_date, :end_date)
  end

  def set_exhibition
    @exhibition = Exhibition.find(params[:id])
  end

  def correct_user
    @exhibition = Exhibition.find(params[:id])
    if @exhibition.user_id != current_user.id
      redirect_to exhibitions_path
    end
  end
end
