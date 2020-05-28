class ExhibitionsController < ApplicationController
  require 'date'
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :correct_data, only: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_exhibition, only: [:show, :edit, :destroy, :update]
  before_action :period_checker, only: [:create, :new]

  def index
    @exhibitions = Exhibition.all
  end

  def new
    if current_user.cart_arts.empty?
      redirect_to user_path(current_user), notice: 'イラストが選択されていません。詳細ページより選択してください。'
    end
    @exhibition = Exhibition.new
    @cart_arts = CartArt.where(user_id: current_user.id)
  end

  def create
    @exhibition = current_user.exhibitions.new(exhibition_params)
    @exhibition.new_exhibition(current_user, exhibition_params) #exhibition.rb参照
      redirect_to thanks_path(@exhibition)
    rescue => e #transactionが失敗した時の処理
      @cart_arts = CartArt.where(user_id: current_user.id)
      render :new
  end

  def show
    @exhibition = Exhibition.find(params[:id])
    @comment = Comment.new
  end

  def update
    if @exhibition.update(exhibition_params)
      redirect_to exhibition_path(@exhibition)
    else
      render :edit
    end
  end

  def destroy
    event = Event.find_by(exhibition_id: @exhibition.id)
    if @exhibition.destroy #同時にイベントを削除
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

  def correct_data #存在しないデータへのアクセス防止
    @exhibition = Exhibition.find_by_id(params[:id])
    if @exhibition.nil?
      redirect_to exhibitions_path, notice: 'お探しのページは表示できません。'
    end
  end

  def correct_user #URL直打ち防止
    @exhibition = Exhibition.find_by_id(params[:id])
    if @exhibition.nil? || @exhibition.user_id != current_user.id
      redirect_to exhibitions_path, notice: 'お探しのページは表示できません。'
    end
  end

  def period_checker #展覧会の重複開催防止。直近のend_dateより現在が過去の場合、展覧会の新規作成はできない。
    exhibition = current_user.exhibitions.maximum(:end_date)
    if exhibition.nil? == false and exhibition > DateTime.now.in_time_zone('Tokyo')
      redirect_to user_path(current_user), notice: '既存の展覧会が終了後、新規展覧会を作成できます。'
    end
  end
end
