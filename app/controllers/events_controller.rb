class EventsController < ApplicationController
  require 'date'
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def index
    @events = Event.where(user_id: current_user.id)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def update
    if@event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to user_path(current_user)
  end

  private
  def event_params
    params.require(:event).permit(:title, :detail, :start_date, :end_date)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def correct_user
    @event = Event.find_by_id(params[:id])
    if @event.nil? || @event.user_id != current_user.id
      redirect_to user_path(current_user), notice: 'お探しのページは表示できません。'
    end
  end
end
