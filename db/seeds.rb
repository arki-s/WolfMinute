# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: “Star Wars” }, { name: “Lord of the Rings” }])
#   Character.create(name: “Luke”, movie: movies.first)
require 'date'
puts "cleaning users, meetings and bookings..."
Booking.destroy_all
Meeting.destroy_all
User.destroy_all

# gender options: 'all' or 'male' or 'female'
gender = 'all'
# age options: 'all' or '12-18' or '19-25' or '26-35' or '35-50' or '50+'
age = '26-35'
# ethnicity options: 'all' or 'asian' or 'white' or 'black' or 'indian' or 'middle_eastern' or 'latino_hispanic'
ethnicity = 'all'

role = ["manager", "employee"]
location = ["room 1", "room 2", "room 3", "room 4", "room 5"]
duration = [15, 20, 30, 60]
now = DateTime.now

objective1 = "<h3>Objectives:</h3>
<ul>
  <li>Highest Priority: Assess the potential benefits and drawbacks of adopting the new accounting software</li>
  <li>Middle Priority: Evaluate the impact of implementing the new accounting software</li>
  <li>Low Priority: Identify potential challenges and risks associated with adopting the new accounting software</li>
</ul>
<h3>Agenda:</h3>
<ol>
  <li>09:30 to 09:35 - Introduction and Welcome (5 minutes)</li>
  <li>09:35 to 09:45 - Overview of the New Accounting Software (10 minutes)</li>
  <li>09:45 to 09:55 - Pros and Cons Discussion (10 minutes)</li>
  <li>09:55 to 10:00 - Next Steps and Conclusion (5 minutes)</li>
</ol>
"

objective2 = "<h3>Objectives:</h3>
<ul>
  <li>Highest Priority: Evaluate the potential benefits and drawbacks of adopting the new accounting software</li>
  <li>Middle Priority: Determine the implementation requirements and timeline for the new accounting software</li>
  <li>Low Priority: Establish a communication plan for stakeholders regarding the new accounting software</li>
</ul>
<h3>Agenda:</h3>
<ol>
  <li>10:00 to 10:05 - Welcome and Introductions (5 minutes)</li>
  <li>10:05 to 10:25 - Presentation on the New Accounting Software (20 minutes)</li>
  <li>10:25 to 10:45 - Group Discussion on Benefits and Drawbacks (20 minutes)</li>
  <li>10:45 to 11:00 - Q&A and Wrap-up (15 minutes)</li>
</ol>
"

objective3 = "<h3>Objectives:</h3>
<ul>
  <li>Highest Priority: Assess the readiness of the organization for adopting the new accounting software</li>
  <li>Middle Priority: Identify the training needs and resources required for successful implementation</li>
  <li>Low Priority: Define the key performance indicators to measure the effectiveness of the new accounting software</li>
</ul>
<h3>Agenda:</h3>
<ol>
  <li>14:00 to 14:10 - Opening Remarks and Introduction (10 minutes)</li>
  <li>14:10 to 14:30 - Presentation on the Benefits and Features of the New Accounting Software (20 minutes)</li>
  <li>14:30 to 14:50 - Discussion on Training and Resource Requirements (20 minutes)</li>
  <li>14:50 to 15:00 - Action Planning and Next Steps (10 minutes)</li>
</ol>
"

objective4 = "<h3>Objectives:</h3>
<ul>
  <li>Highest Priority: Determine the cost-benefit analysis of adopting the new accounting software</li>
  <li>Middle Priority: Assess the impact on existing processes and workflows</li>
  <li>Low Priority: Identify potential training needs and strategies for successful implementation</li>
</ul>
<h3>Agenda:</h3>
<ol>
  <li>13:30 to 13:35 - Introduction and Meeting Overview (5 minutes)</li>
  <li>13:35 to 13:55 - Presentation on the New Accounting Software Features (20 minutes)</li>
  <li>13:55 to 14:10 - Discussion on Cost-Benefit Analysis (15 minutes)</li>
  <li>14:10 to 14:25 - Assessment of Process and Workflow Impact (15 minutes)</li>
  <li>14:25 to 14:40 - Brainstorming Training Needs and Strategies (15 minutes)</li>
  <li>14:40 to 14:45 - Wrap-up and Next Steps (5 minutes)</li>
</ol>
"

objectives = [objective1, objective2, objective3, objective4]

juan = User.create!(
  name: "Juan Bernal",
  email: "juan-bernal@wolfminute.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone
)

jun = User.create!(
  name: "Jun Ukemori",
  email: "jun-ukemori@wolfminute.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone
)

test_user = User.create!(
  name: "testuser",
  email: "test@email.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone,
  admin: true
)

  url = "https://this-person-does-not-exist.com/new?gender=#{gender}&age=#{age}&etnic=#{ethnicity}"
  json = URI.open(url).read
  src = JSON.parse(json)['src']
  photo_url = "https://this-person-does-not-exist.com#{src}"
  file = URI.open(photo_url)
  test_user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')

puts "created test user"



2.times do
  past_day = DateTime.new(now.year, now.month, rand(1..25), rand(0..8), [15, 30, 45, 0].sample, 0)
  while past_day.wday == 0 || past_day.wday == 6
    past_day = DateTime.new(now.year, now.month, rand(1..25), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: test_user,
    start_date: past_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: test_user,
    meeting: test_meeting,
    status: "accepted" # or just 'accepted'
  )
end

2.times do
  future_day = DateTime.new(now.year, now.month, rand(27..31), rand(0..8), [15, 30, 45, 0].sample, 0)
  while future_day.wday == 0 || future_day.wday == 6
    future_day = DateTime.new(now.year, now.month, rand(27..31), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: test_user,
    start_date: future_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )
  Booking.create!(
    user: test_user,
    meeting: test_meeting,
    status: "accepted" # or just 'accepted'
  )
end

puts "created meeting"

20.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    role: role.sample,
    job_title: Faker::Job.title,
    mobile: Faker::PhoneNumber.cell_phone,
    password: "123456"
  )
    url = "https://this-person-does-not-exist.com/new?gender=#{gender}&age=#{age}&etnic=#{ethnicity}"
    json = URI.open(url).read
    src = JSON.parse(json)['src']
    photo_url = "https://this-person-does-not-exist.com#{src}"
    file = URI.open(photo_url)
    user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    user.save
  puts "created #{User.count} users!"

rand(1..5).times do
  day = DateTime.new(now.year, now.month, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
while day.wday == 0 || day.wday == 6
  day = DateTime.new(now.year, now.month, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
end
  meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: user,
    start_date: day,
    end_date: day + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: user,
    meeting: meeting,
    status: "accepted" # or just 'accepted'
  )
end

rand(1..5).times do
  day2 = DateTime.new(now.year, 4, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
while day2.wday == 0 || day2.wday == 6
  day2 = DateTime.new(now.year, 4, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
end
  meeting_april = Meeting.create!(
    title: Faker::Company.buzzword,
    user: user,
    start_date: day2,
    end_date: day2 + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: user,
    meeting: meeting_april,
    status: "accepted" # or just 'accepted'
  )
end

rand(1..5).times do
  day3 = DateTime.new(now.year, 3, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
while day3.wday == 0 || day3.wday == 6
  day3 = DateTime.new(now.year, 3, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
end
  meeting_march = Meeting.create!(
    title: Faker::Company.buzzword,
    user: user,
    start_date: day3,
    end_date: day3 + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: user,
    meeting: meeting_march,
    status: "accepted" # or just 'accepted'
  )
end

rand(1..5).times do
  day4 = DateTime.new(now.year, 6, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
while day4.wday == 0 || day4.wday == 6
  day4 = DateTime.new(now.year, 6, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0)
end
  meeting_june = Meeting.create!(
    title: Faker::Company.buzzword,
    user: user,
    start_date: day4,
    end_date: day4 + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: user,
    meeting: meeting_june,
    status: "accepted" # or just 'accepted'
  )
end

  puts "created #{Meeting.count} meetings!"
end

Meeting.find_each do |meeting|
  # create a booking for each user
  User.find_each do |user|
    if user.id != meeting.user_id && rand(0..3) == 0
      Booking.create!(
        user: user,
        meeting: meeting,
        status: Booking.statuses.keys.sample # or just 'accepted'
      )
    end
  end
end

puts "created #{Booking.count} bookings!"


# fortesting by Rika start from here!!!

# tesuser1 = User.create(
#   name: "tes1user",
#   email: "tes1@email.com",
#   role: role.sample,
#   password: "123456",
#   job_title: Faker::Job.title,
#   mobile: Faker::PhoneNumber.cell_phone
# )
# tesuser2 = User.create(
#   name: "tes2user",
#   email: "tes2@email.com",
#   role: role.sample,
#   password: "123456",
#   job_title: Faker::Job.title,
#   mobile: Faker::PhoneNumber.cell_phone
# )
# puts "created #{User.count} testusers for Rika"

# tesmeeting1 = Meeting.create!(
#   title: "for tes1",
#   user: tesuser1,
#   start_date: Time.local(2023, 5, 23, 9, 0),
#   end_date: Time.local(2023, 5, 23, 11, 0),
#   description: Faker::Company.catch_phrase,
#   location: location.sample,
#   duration: 2
# )

# testbooking1 = Booking.create!(
#   user: tesuser1,
#   meeting: tesmeeting1
# )

# tesmeeting2 = Meeting.create!(
#   title: "for tes1-2",
#   user: tesuser1,
#   start_date: Time.local(2023, 5, 23, 15, 0),
#   end_date: Time.local(2023, 5, 23, 16, 0),
#   description: Faker::Company.catch_phrase,
#   location: location.sample,
#   duration: 1
# )

# testbooking1 = Booking.create!(
#   user: tesuser1,
#   meeting: tesmeeting2
# )

# tesmeeting3 = Meeting.create!(
#   title: "for tes2",
#   user: tesuser2,
#   start_date: Time.local(2023, 5, 23, 10, 0),
#   end_date: Time.local(2023, 5, 23, 13, 0),
#   description: Faker::Company.catch_phrase,
#   location: location.sample,
#   duration: 2
# )

# testbooking3 = Booking.create!(
#   user: tesuser2,
#   meeting: tesmeeting3
# )

# tesmeeting4 = Meeting.create!(
#   title: "for tes2-2",
#   user: tesuser2,
#   start_date: Time.local(2023, 5, 23, 17, 0),
#   end_date: Time.local(2023, 5, 23, 18, 0),
#   description: Faker::Company.catch_phrase,
#   location: location.sample,
#   duration: 1
# )

# testbooking4 = Booking.create!(
#   user: tesuser2,
#   meeting: tesmeeting4
# )

# puts "created #{Booking.count} bookings for Rika"
# puts "created #{Meeting.count} meetings for Rika"
# fortesting by Rika until here!!!
