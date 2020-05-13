class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = Event.where(user_id: current_user.id)
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
end
