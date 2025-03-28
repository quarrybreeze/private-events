class UsersController < ApplicationController
  def show
    @user = User.includes(attendances: :attended_event).find(params[:id])
    @events_created = @user.created_events
    @attended_events = @user.attended_events

  end
end
