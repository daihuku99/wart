class EventsController < ApplicationController
  require 'date'
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def index
    @events = Event.where(user_id: current_user.id)
  end

  def new
    @event = Event.new
  end

  def create
    event = current_user.events.new(event_params)
    event.save
    redirect_to user_path(current_user)
  end

  def update
    @event.update(event_params)
    redirect_to event_path(@event)
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
    @event = Event.find(params[:id])
    if @event.user_id != current_user.id
      redirect_to user_path(current_user)
    end
  end
end
