class EventsController < ApplicationController
  def index
    @events = Event.includes(:creator).all
  end

  def show
    @event = Event.includes(:creator).find(params[:id])
    @current_user = current_user
  end

  before_action :authenticate_user!

  def new
    @event = current_user.created_events.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to root_path, notice: "Event was created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Event was deleted successfully"
  end

  private
  def event_params
    params.require(:event).permit(:when,:title,:location)
  end
end
