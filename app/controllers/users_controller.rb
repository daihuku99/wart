class UsersController < ApplicationController
  require 'date'
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :correct_user, only: [:edit, :update, :confirm, :withdrawal]
  def index
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @arts = @user.arts.page(params[:page]).reverse_order
    @exhibitions = @user.exhibitions.page(params[:page]).reverse_order
    if user_signed_in?
      @events = Event.where(user_id: current_user.id)
    end
    @event = Event.new
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def withdrawal #退会機能
    current_user.update(is_deleted:true)
    reset_session #ログアウト
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user #URL直打ち防止
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to users_path, notice: 'お探しのページは表示できません。'
    end
  end
end
