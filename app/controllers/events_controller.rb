class EventsController < ApplicationController
  require 'date'
  def index
    @events = Event.all
  end

  def create
    event = current_user.events.new(event_params)
    event.save
    redirect_to user_path(current_user)
  end

  def show
    @event = Event.find(params[:id])
  end

  private
  def event_params
    params.require(:event).permit(:title, :detail, :start_date, :end_date)
  end
end
