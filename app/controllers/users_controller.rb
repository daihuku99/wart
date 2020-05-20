class UsersController < ApplicationController
  require 'date'
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    if user_signed_in?
      @events = Event.where(user_id: current_user.id)
    end
    @event = Event.new
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(current_user)
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :user_status)
  end

  def correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to users_path
    end
  end
end
