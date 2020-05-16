class ExhibitionsController < ApplicationController
  require 'date'
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_exhibition, only: [:show, :edit, :destroy, :update]
  before_action :period_checker, only: [:create, :new]

  def index
    @exhibitions = Exhibition.all
  end

  def new
    @exhibition = Exhibition.new
    @cart_arts = CartArt.where(user_id: current_user.id)
  end

  def create
    @exhibition = current_user.exhibitions.new(exhibition_params)
    @exhibition.new_exhibition(current_user, exhibition_params)
      redirect_to thanks_path(@exhibition)
    rescue => e
      @cart_arts = CartArt.where(user_id: current_user.id)
      render :new
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

  def period_checker
    exhibition = current_user.exhibitions.maximum(:end_date)
    if exhibition > DateTime.now.in_time_zone('Tokyo')
      redirect_to user_path(current_user), notice: '既存の展覧会が終了後、新規展覧会を作成できます。'
    end
  end
end
