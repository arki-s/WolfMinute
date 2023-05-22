class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end


  def show
    @meeting = Meeting.find(:params[:id])
    @booking = @meeting.bookings
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      redirect_to meetings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def meeting_params

  end
end
