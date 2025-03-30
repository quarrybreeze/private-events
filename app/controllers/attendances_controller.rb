class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @attendance = Attendance.new(attendance_params)
  end

  def create
    @event = Event.find(params[:event_id])
    @attendance = current_user.attendances.new(attended_event: @event)

    if @attendance.save
      redirect_to @event, notice: "You have successfully signed up to attend."
    else
      redirect_to @event, notice: "Issue registering for event"
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.find_by(attendee_id: current_user.id)
    @attendance.destroy
    redirect_to @event, notice: "You have successfully cancelled your RSVP."
  end
end
