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

wage = [250000, 350000, 450000, 550000, 650000, 750000, 850000, 950000, 1500000, 3000000]

title = ["Strat Plan Retreat: Mapping Success",
  "Leadership Workshop: Unlocking Potential",
  "Sales Strategy Summit: Accelerate Growth",
  "Innovation Forum: Ignite Creativity",
  "Marketing Analytics: Data-Driven Decisions",
  "Team Building: Unite for Success",
  "Financial Forecast Review: Navigating Trends",
  "Product Launch: Unveiling Next Big Thing",
  "Client Relationship: Cultivate Trust",
  "Change Management: Embrace Transformation",
  "Project Update: Milestones & Deliverables",
  "Training & Development: Continuous Learning",
  "Risk Assessment Workshop: Manage Uncertainty",
  "Customer Experience: Delightful Journeys",
  "Supplier Collaboration: Strong Partnerships",
  "Diversity & Inclusion: Foster Belonging",
  "Operations Optimization: Streamline Efficiency",
  "Employee Town Hall: Boost Engagement",
  "Market Research: Insights for Advantage",
  "Crisis Management: Preparedness & Resilience",
  "Investor Relations: Build Confidence",
  "Brand Positioning: Compelling Identity",
  "Supply Chain Optimization: Efficient Logistics",
  "Talent Acquisition: Attract Top Talent",
  "Sustainability Forum: Positive Impact",
  "IT Planning: Future-proof Technology",
  "M&A Forum: Maximize Synergies",
  "Quality Assurance: Excellence in Delivery",
  "Partnership Meeting: Strategic Alliances",
  "Customer Feedback: Enhance Experience"
  ]

role = ["Manager", "Employee", "Director", "Chief", "CEO", "Member of the board", "Temporary Employee"]
location = ["room 1", "room 2", "room 3", "room 4", "room 5"]
durationm = [15, 20, 30, 45, 60]
duration = [50, 60]
durationa = [30, 45, 50, 60]
durationmm = [45, 50, 60]
now = DateTime.now

objective1 = "Objectives:

  Highest Priority: Assess the potential benefits and drawbacks of adopting the new accounting software
  Middle Priority: Evaluate the impact of implementing the new accounting software
  Low Priority: Identify potential challenges and risks associated with adopting the new accounting software

Agenda:

  From 09:30 to 09:35 Introduction and Welcome (5 minutes)
  From 09:35 to 09:45 Overview of the New Accounting Software (10 minutes)
  From 09:45 to 09:55 Pros and Cons Discussion (10 minutes)
  From 09:55 to 10:00 Next Steps and Conclusion (5 minutes)

"

objective2 = "Objectives:

  Highest Priority: Evaluate the potential benefits and drawbacks of adopting the new accounting software
  Middle Priority: Determine the implementation requirements and timeline for the new accounting software
  Low Priority: Establish a communication plan for stakeholders regarding the new accounting software

Agenda:

  From 10:00 to 10:05 Welcome and Introductions (5 minutes)
  From 10:05 to 10:25 Presentation on the New Accounting Software (20 minutes)
  From 10:25 to 10:45 Group Discussion on Benefits and Drawbacks (20 minutes)
  From 10:45 to 11:00 Q&A and Wrap-up (15 minutes)

"

objective3 = "Objectives:

  Highest Priority: Assess the readiness of the organization for adopting the new accounting software
  Middle Priority: Identify the training needs and resources required for successful implementation
  Low Priority: Define the key performance indicators to measure the effectiveness of the new accounting software

Agenda:

  From 14:00 to 14:10 Opening Remarks and Introduction (10 minutes)
  From 14:10 to 14:30 Presentation on the Benefits and Features of the New Accounting Software (20 minutes)
  From 14:30 to 14:50 Discussion on Training and Resource Requirements (20 minutes)
  From 14:50 to 15:00 Action Planning and Next Steps (10 minutes)

"

objective4 = "Objectives:

  Highest Priority: Determine the cost-benefit analysis of adopting the new accounting software
  Middle Priority: Assess the impact on existing processes and workflows
  Low Priority: Identify potential training needs and strategies for successful implementation

Agenda:

  From 13:30 to 13:35 Introduction and Meeting Overview (5 minutes)
  From 13:35 to 13:55 Presentation on the New Accounting Software Features (20 minutes)
  From 13:55 to 14:10 Discussion on Cost-Benefit Analysis (15 minutes)
  From 14:10 to 14:25 Assessment of Process and Workflow Impact (15 minutes)


"

objectives = [objective1, objective2, objective3, objective4]

test_user = User.create!(
  name: "testuser",
  email: "test@wolfminute.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone,
  admin: true,
  wage: wage.sample
)

puts "created test user of test@wolfminute.com"

juan = User.create!(
  name: "Juan Bernal",
  email: "juan-bernal@wolfminute.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone,
  wage: 4000000,
  admin: true
)
    file = URI.open("https://avatars.githubusercontent.com/u/125519096?v=4")
    juan.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    juan.save

puts "created Juan"

jun = User.create!(
  name: "Jun Ukemori",
  email: "jun-ukemori@wolfminute.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone,
  wage: 3000000,
  admin: true
)

file = URI.open("https://avatars.githubusercontent.com/u/124132832?v=4")
    jun.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    jun.save

    puts "created Jun"



mei = User.create!(
  name: "Mei",
  email: "mei@wolfminute.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone,
  wage: 3000000,
  admin: true
)

file = URI.open("https://avatars.githubusercontent.com/u/123852550?v=4")
    mei.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    mei.save

    puts "created Mei"



rika = User.create!(
  name: "Rika Saito",
  email: "rika-saito@wolfminute.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone,
  wage: 3000000,
  admin: true
)
file = URI.open("https://avatars.githubusercontent.com/u/129135201?v=4")
    rika.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    rika.save

puts "created Rika"

test_video = Video.create!(
  start_date: DateTime.new(now.year, now.month, rand(1..29), rand(0..8), [15, 30, 45, 0].sample, 0),
  duration: duration.sample,
  transcript: "Meeting Chairman: If we are all here, let's get started. First of all, I'd like you to please join me in welcoming Jack Peterson, our Southwest Area Sales Vice President.
              Jack Peterson: Thank you for having me, I'm looking forward to today's meeting.
              Meeting Chairman: I'd also like to introduce Margaret Simmons who recently joined our team.
              Margaret Simmons: May I also introduce my assistant, Bob Hamp.
              Meeting Chairman: Welcome Bob. I'm afraid our national sales director, Anne Trusting, can't be with us today. She is in Kobe at the moment, developing our Far East sales force.
              Meeting Chairman: Let's get started. We're here today to discuss ways of improving sales in rural market areas. First, let's go over the report from the last meeting which was held on June 24th. Right, Tom, over to you.
              Tom Robbins: Thank you Mark. Let me just summarize the main points of the last meeting. We began the meeting by approving the changes in our sales reporting system discussed on May 30th. After briefly revising the changes that will take place, we moved on to a brainstorming session concerning after customer support improvements. You'll find a copy of the main ideas developed and discussed in these sessions in the photocopies in front of you. The meeting was declared closed at 11.30.
              Meeting Chairman: Thank you Tom. So, if there is nothing else we need to discuss, let's move on to today's agenda. Have you all received a copy of today's agenda? If you don't mind, I'd like to skip item 1 and move on to item 2: Sales improvement in rural market areas. Jack has kindly agreed to give us a report on this matter. Jack?
              Jack Peterson: Before I begin the report, I'd like to get some ideas from you all. How do you feel about rural sales in your sales districts? I suggest we go round the table first to get all of your input.
              John Ruting: In my opinion, we have been focusing too much on urban customers and their needs. The way I see things, we need to return to our rural base by developing an advertising campaign to focus on their particular needs.
              Alice Linnes: I'm afraid I can't agree with you. I think rural customers want to feel as important as our customers living in cities. I suggest we give our rural sales teams more help with advanced customer information reporting.
              Donald Peters: Excuse me, I didn't catch that. Could you repeat that, please?
              Alice Linnes: I just stated that we need to give our rural sales teams better customer information reporting.
              John Ruting: I don't quite follow you. What exactly do you mean?
              Alice Linnes: Well, we provide our city sales staff with database information on all of our larger clients. We should be providing the same sort of knowledge on our rural customers to our sales staff there.
              Jack Peterson: Would you like to add anything, Jennifer?
              Jennifer Miles: I must admit I never thought about rural sales that way before. I have to agree with Alice.
              Jack Peterson: Well, let me begin with this Power Point presentation (Jack presents his report). As you can see, we are developing new methods to reach out to our rural customers.
              John Ruting: I suggest we break up into groups and discuss the ideas we've seen presented.
              Meeting Chairman: Unfortunately, we're running short of time. We'll have to leave that to another time.
              Jack Peterson: Before we close, let me just summarize the main points:
              Rural customers need special help to feel more valued.
              Our sales teams need more accurate information on our customers.
              A survey will be completed to collect data on spending habits in these areas.
              The results of this survey will be delivered to our sales teaMs
              We are considering specific data mining procedures to help deepen our understanding.
              Meeting Chairman: Thank you very much Jack. Right, it looks as though we've covered the main items Is there any other business?
              Donald Peters: Can we fix the next meeting, please?
              Meeting Chairman: Good idea Donald. How does Friday in two weeks time sound to everyone? Let's meet at the same time, 9 o'clock. Is that OK for everyone? Excellent. I'd like to thank Jack for coming to our meeting today. The meeting is closed.",
  summary: "We welcomed Jack Peterson, our Southwest Area Sales Vice President, and introduced Margaret Simmons, a new team member.
            \nTom Robbins summarized the main points from our previous meeting, which focused on approving changes to the sales reporting system and discussing after customer support improvements.
            \nJack Peterson presented a report highlighting the need for special assistance for rural customers to feel valued, the importance of providing accurate customer information to our sales teams, and plans for conducting a survey on spending habits in rural areas.
            \nDue to time constraints, further discussions were postponed, and we scheduled our next meeting for Friday in two weeks' time at 9 o'clock.",
  actions: "1. Develop an advertising campaign to focus on the particular needs of rural customers.\n   Responsible: John Ruting\n\n2. Provide better customer information reporting to the rural sales teams.\n   Responsible: Alice Linnes\n\n3. Conduct a survey to collect data on spending habits in rural areas.\n   Responsible: To be assigned (not specified in the meeting transcript)"
)
audio_file = File.open("app/assets/audios/meeting_sample.m4a")
test_video.audio.attach(io: audio_file, filename: "meeting_sample.m4a", content_type: "audio/mp4")
test_video.save

puts "created a video sample"
  # url = "https://this-person-does-not-exist.com/new?gender=#{gender}&age=#{age}&etnic=#{ethnicity}"
  # json = URI.open(url).read
  # src = JSON.parse(json)['src']
  # photo_url = "https://this-person-does-not-exist.com#{src}"
  # file = URI.open(photo_url)
  # test_user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')


9.times do
  future_day = DateTime.new(now.year, now.month, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  while future_day.wday == 0 || future_day.wday == 6
    future_day = DateTime.new(now.year, now.month, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: title.sample,
    user: jun,
    start_date: future_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )
  Booking.create!(
    user: jun,
    meeting: test_meeting,
    status: "accepted" # or just 'accepted'
  )
end

8.times do
  past_day = DateTime.new(now.year, 5, rand(1..31), rand(0..8), [15, 30, 45, 0].sample, 0)
  while past_day.wday == 0 || past_day.wday == 6
    past_day = DateTime.new(now.year, 5, rand(1..31), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: title.sample,
    user: jun,
    start_date: past_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationmm.sample,
    objectives: objectives.sample,
    video: test_video
  )

  test_meeting.video = test_video

  Booking.create!(
    user: jun,
    meeting: test_meeting,
    status: "accepted" # or just 'accepted'
  )
end

7.times do
  april_day = DateTime.new(now.year, 4, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  while april_day.wday == 0 || april_day.wday == 6
    april_day = DateTime.new(now.year, 4, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: jun,
    start_date: april_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationa.sample,
    objectives: objectives.sample
  )
  Booking.create!(
    user: jun,
    meeting: test_meeting,
    status: "accepted" # or just 'accepted'
  )
end

6.times do
  march_day = DateTime.new(now.year, 3, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  while march_day.wday == 0 || march_day.wday == 6
    march_day = DateTime.new(now.year, 3, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: jun,
    start_date: march_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationm.sample,
    objectives: objectives.sample
  )
  Booking.create!(
    user: jun,
    meeting: test_meeting,
    status: "accepted" # or just 'accepted'
  )
end


9.times do
  future_day = DateTime.new(now.year, now.month, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  while future_day.wday == 0 || future_day.wday == 6
    future_day = DateTime.new(now.year, now.month, rand(4..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: title.sample,
    user: mei,
    start_date: future_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample
  )
  Booking.create!(
    user: mei,
    meeting: test_meeting,
    status: "accepted"
  )
end

7.times do
  april_day = DateTime.new(now.year, 4, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  while april_day.wday == 0 || april_day.wday == 6
    april_day = DateTime.new(now.year, 4, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: mei,
    start_date: april_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationa.sample,
    objectives: objectives.sample
  )
  Booking.create!(
    user: mei,
    meeting: test_meeting,
    status: "accepted"
  )
end

6.times do
  march_day = DateTime.new(now.year, 3, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  while march_day.wday == 0 || march_day.wday == 6
    march_day = DateTime.new(now.year, 3, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: mei,
    start_date: march_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationm.sample,
    objectives: objectives.sample
  )
  Booking.create!(
    user: mei,
    meeting: test_meeting,
    status: "accepted"
  )
end

8.times do
  past_day = DateTime.new(now.year, 5, rand(1..31), rand(0..8), [15, 30, 45, 0].sample, 0)
  while past_day.wday == 0 || past_day.wday == 6
    past_day = DateTime.new(now.year, 5, rand(1..31), rand(0..8), [15, 30, 45, 0].sample, 0)
  end
  test_meeting = Meeting.create!(
    title: title.sample,
    user: mei,
    start_date: past_day,
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationmm.sample,
    objectives: objectives.sample,
    video: test_video
  )

  test_meeting.video = test_video

  Booking.create!(
    user: mei,
    meeting: test_meeting,
    status: "accepted"
  )
end

dday = DateTime.new(now.year, 6, 5, 9, 0, 0)
ddday = DateTime.new(now.year, 6, 5, 9, 45, 0)

ttest = Meeting.create!(
  title: title.sample,
  user: test_user,
  start_date: dday,
  end_date: ddday,
  description: Faker::Company.catch_phrase,
  location: location.sample,
  duration: 45,
  objectives: objectives.sample
)
Booking.create!(
  user: test_user,
  meeting: ttest,
  status: "accepted"
)

puts "created #{Meeting.count}meetings"

20.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Name.first_name + "-" + Faker::Name.last_name + "@wolfminute.com",
    role: role.sample,
    job_title: Faker::Job.title,
    mobile: Faker::PhoneNumber.cell_phone,
    password: "123456",
    wage: wage.sample
  )
    url = "https://this-person-does-not-exist.com/new?gender=#{gender}&age=#{age}&etnic=#{ethnicity}"
    json = URI.open(url).read
    src = JSON.parse(json)['src']
    photo_url = "https://this-person-does-not-exist.com#{src}"
    file = URI.open(photo_url)
    user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    user.save
  puts "created #{User.count} users!"

rand(8..9).times do
  day = DateTime.new(now.year, now.month, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
while day.wday == 0 || day.wday == 6
  day = DateTime.new(now.year, now.month, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
end

if day < DateTime.now
  meeting = Meeting.create!(
    title: title.sample,
    user: user,
    start_date: day,
    end_date: day + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample,
    video: test_video
  )

  Booking.create!(
    user: user,
    meeting: meeting,
    status: "accepted"
  )

else
  meeting = Meeting.create!(
    title: title.sample,
    user: user,
    start_date: day,
    end_date: day + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample,
    objectives: objectives.sample,
  )

  Booking.create!(
    user: user,
    meeting: meeting,
    status: "accepted"
  )
end
end

rand(6..7).times do
  day2 = DateTime.new(now.year, 4, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
while day2.wday == 0 || day2.wday == 6
  day2 = DateTime.new(now.year, 4, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
end
  meeting_april = Meeting.create!(
    title: title.sample,
    user: user,
    start_date: day2,
    end_date: day2 + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationa.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: user,
    meeting: meeting_april,
    status: "accepted"
  )
end

rand(5..6).times do
  day3 = DateTime.new(now.year, 3, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
while day3.wday == 0 || day3.wday == 6
  day3 = DateTime.new(now.year, 3, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
end
  meeting_march = Meeting.create!(
    title: title.sample,
    user: user,
    start_date: day3,
    end_date: day3 + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationm.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: user,
    meeting: meeting_march,
    status: "accepted"
  )
end

rand(7..8).times do
  day4 = DateTime.new(now.year, 5, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
while day4.wday == 0 || day4.wday == 6
  day4 = DateTime.new(now.year, 5, rand(1..30), rand(0..8), [15, 30, 45, 0].sample, 0)
end
  meeting_may = Meeting.create!(
    title: title.sample,
    user: user,
    start_date: day4,
    end_date: day4 + Rational(duration.sample, 24 * 60),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: durationmm.sample,
    objectives: objectives.sample
  )

  Booking.create!(
    user: user,
    meeting: meeting_may,
    status: "accepted"
  )
end

  puts "created #{Meeting.count} meetings!"
end

Meeting.find_each do |meeting|
  User.find_each do |user|
    if user.id != meeting.user_id && rand(0..4) == 0
      Booking.create!(
        user: user,
        meeting: meeting,
        status: Booking.statuses.keys.sample # or just 'accepted'
      )
    end
  end
end

puts "created #{Booking.count} bookings!"
