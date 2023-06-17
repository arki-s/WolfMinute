class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :meetings, through: :bookings
  has_many :meetings_as_owner, class_name: "Meeting", foreign_key: "user_id"
  has_one_attached :photo

  validates :name, presence: true
  validates :job_title, presence: true
  validates :mobile, presence: true
  validates :role, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 def available_time(year, month, day)
  date = Time.local(year, month, day)
  today_meetings = self.meetings.where(start_date: date.beginning_of_day..date.end_of_day)
  time_slots = (9..18).to_a
  hash = {}
  if today_meetings.count >= 1
  time_slots.each do |hour|
    hash[hour] = true
    today_meetings.each { |meeting| (meeting.start_date.hour...meeting.start_date.hour + (meeting.duration.to_i / 60)).to_a.each { |hour| hash[hour] = false } }
    end
  hash
  else
  time_slots.each { |hour| hash[hour] = true }
  end
  hash.select { |key, value| value == true }.keys
end

def self.find_available(users)
    # users should be the array of attendees
  date = Date.tomorrow
  while date.saturday? || date.sunday?
    date += 1
  end
  count = users.count
  array = users.map { |user| user.available_time(date.year, date.month, date.day) }.flatten.sort
  ava = array.select { |value| array.count(value) >= count }.uniq
  while ava.count.zero?
    date = Date.tomorrow + 1
    while date.saturday? || date.sunday?
      date + 1
    end
    array = users.map { |user| user.available_time(date.year, date.month, date.day) }.flatten.sort
    ava = array.select { |value| array.count(value) >= count }.uniq
  end
  return DateTime.parse("2023-#{date.month}-#{date.day} #{ava.min}:00:00")
end

end
