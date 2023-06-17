class Meeting < ApplicationRecord
  belongs_to :video, optional: true
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many :messages, dependent: :destroy

  validates :description, presence: true
  validates :duration, presence: true
  validates :location, presence: true
  validates :start_date, presence: true

  def sync_to_google_calendar(users_names)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = Google::Apis::RequestOptions.default.authorization

    meeting = Google::Apis::CalendarV3::Event.new(
      summary: title,
      description: description,
      start: {
        date_time: start_date.iso8601
      },
      end: {
        date_time: end_date.iso8601
      },
      location: location,
      attendees: build_attendees_list(users_names)
    )

        # Insert the event into Google Calendar
        calendar_id = 'primary' # Use 'primary' for the default calendar
        result = service.insert_event(calendar_id, meeting)

        # Handle the result
        if result.status == 'confirmed'
          # Event successfully added to Google Calendar
        else
          # Handle the error, e.g., log it or show an error message
        end
      end



      def build_attendees_list(users_names)
        attendees_list = []
        users_names.each do |name|
          user_instance = User.find_by(name: name)
          attendees_list << Google::Apis::CalendarV3::EventAttendee.new(email: user_instance.email) if user_instance.present?
        end
        attendees_list
      end

end
