require 'opentok'
class VideoController < ApplicationController
  before_action :set_opentok_vars
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped


  def party
    @meeting = Meeting.find(params[:meeting_id])
    agenda_string = @meeting.objectives
    time_title_regex = /(\d{2}:\d{2}) to \d{2}:\d{2} - (.*?) \(\d+ minutes\)/
    matches = agenda_string.scan(time_title_regex)
    @agenda_items = matches.flatten

  end

  def name
    redirect_to meeting_party_url(@meeting)
  end

  def screenshare
    @darkmode = 'dark'
  end

  private

  def set_opentok_vars
    @api_key = ENV['OPENTOK_API_KEY']
    @api_secret = ENV['OPENTOK_API_SECRET']
    @session_id = Session.create_or_load_session_id
    @moderator_name = ENV['MODERATOR_NAME']
    @meeting = Meeting.find(params[:meeting_id])
    @name ||= @meeting.title
    @token = Session.create_token(@name, @moderator_name, @session_id)
  end

  def name_params
    params.permit(:name, :password, :authenticity_token, :commit)
  end
end