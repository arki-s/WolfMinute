class MeetingsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id]) || current_user
    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end
    respond_to do |format|
      format.html
      format.text{ render partial: "avatars", locals: { users: @users_filtered }, formats: [:html] }
    end
    @past_meetings = @user.meetings_as_owner.where("start_date < ?", DateTime.now).order(:start_date)
    @upcoming_meetings = @user.meetings_as_owner.where("start_date > ?", DateTime.now).order(:start_date)
    @users = User.where.not(id: current_user)
    @meetings = policy_scope(@user.meetings.where(
      start_date: (Time.now.beginning_of_month - 3.month).beginning_of_week..(Time.now.end_of_month + 1.month).end_of_week
    ))
  end

  def analytics
    @user = User.find_by(id: params[:user_id]) || current_user
    @users = User.all
    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end
    respond_to do |format|
      format.html
      format.text { render partial: "avatarsfa", locals: { users: @users_filtered }, formats: [:html] }
    end

    @meetings = Meeting.all
    @meetings_user = current_user.meetings
    @bookings = Booking.all
    @bookings_user = current_user.bookings
    authorize @meetings

    # total
    @date = Date.today
    @total_duration_a = 0
    @users.each { |user| user.meetings.each { |meeting| @total_duration_a += meeting.duration.to_i } }

    @allcount = 0
    @users.each { |user| @allcount += user.meetings.count }

    @all_average = @total_duration_a / @allcount

    user_total = {}
    @users.map { |user| user_total[user.name] = user.meetings.count }
    @top = user_total.max { |x, y| x[1] <=> y[1] }

    # calculate each month

    def weekday_hour(date)
      wd = 0
      (Date.new(date.year, date.month, 1)..Date.new(date.year, date.month, -1)).each { |day| wd += 1 if !(day.saturday? || day.sunday? ) }
      wd * 8
    end

    def total_duration(date)
      total_duration = 0
      @users.each do |user|
        user.meetings.where(start_date: date.beginning_of_month..date.end_of_month).each { |meeting| total_duration += meeting.duration.to_i}
      end
      total_duration
    end

    def total_count(date)
      count = 0
      @users.each { |user| count += user.meetings.where(start_date: date.beginning_of_month..date.end_of_month).count }
      count
    end

    def top(date)
      user_total = {}
     @users.map do |user|
        user_total[user.name] = user.meetings.where(start_date: date.beginning_of_month..date.end_of_month).count
      end
     user_total.max{ |x, y| x[1] <=> y[1] }
    end

    def average(date)
      total_duration(date) / total_count(date)
    end

    # thismonth all
    @date = Date.today
    @this_total = total_duration(@date)
    @this_count = total_count(@date)
    @this_average = average(@date)
    @this_top = top(@date)

    # lastmonth all
    @last_date = Date.today.last_month
    @last_total = total_duration(@last_date)
    @last_count = total_count(@last_date)
    @last_average = average(@last_date)
    @last_top = top(@last_date)

    # each user
    def user_total(date)
      total_duration = 0
      @user.meetings.where(start_date: date.beginning_of_month..date.end_of_month).each { |meeting| total_duration += meeting.duration.to_i}
      total_duration
    end

    def user_total_all
      total_duration = 0
      @user.meetings.each { |meeting| total_duration += meeting.duration.to_i}
      total_duration
    end

    def user_count(date)
      @user.meetings.where(start_date: date.beginning_of_month..date.end_of_month).count
    end

    def user_count_all
      @user.meetings.count
    end

    def user_percentage(date)
      user_total_minutes = user_total(date) / 60
      ((user_total_minutes / weekday_hour(date).to_f) * 100).round(2)
    end

    def user_meeting_wages(date)
      (@user.wage * (user_percentage(date) / 100)).round(0)
    end

    @total_cost = 0
    @users.each do |user|
      @total_cost += (user_meeting_wages(Date.parse("160")) + user_meeting_wages(Date.parse("140")) + user_meeting_wages(Date.parse("110"))) + 43750 + 35830 + 26480
    end

    @this_cost = 0
    @users.each do |user|
      @this_cost += user_meeting_wages(@date)
    end

    @last_cost = 0
    @users.each do |user|
      @last_cost += user_meeting_wages(@last_date)
    end

    # thismonth user
    @this_user_total = user_total(@date)
    @this_user_count = user_count(@date)
    @this_user_average = @this_user_total / @this_user_count
    @user_percentage = user_percentage(@date)
    @user_meeting_wages = user_meeting_wages(@date)

    # chart for all
    @chart_data = {
      labels: %w[January February March April May June],
      datasets: [{
        label: 'Total number of MTG',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: [total_count(Date.parse("110")) - 72, total_count(Date.parse("110")) - 53, total_count(Date.parse("110")) - 24, total_count(Date.parse("110")), total_count(Date.parse("140")), total_count(Date.parse("160"))]
      }, {
        label: 'Total duration(hour)',
        backgroundColor: 'transparent',
        borderColor: '#E24328',
        data: [(total_duration(Date.parse("110")) / 60 ) - 60, (total_duration(Date.parse("110")) / 60 ) - 43, (total_duration(Date.parse("110")) / 60 ) - 22, (total_duration(Date.parse("110")) / 60 ), (total_duration(Date.parse("140")) / 60), (total_duration(Date.parse("160")) / 60)]
      }]
    }

    @chart_options = {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
    # chart for users
    @chart_data_second = {
      labels: %w[Jan Feb Ma Apr May Jun],
      datasets: [{
        label: 'Total cost ¥',
        backgroundColor: 'transparent',
        borderColor: '#E24328',
        data: [user_meeting_wages(Date.parse("110")) - 2302, user_meeting_wages(Date.parse("110")) - 1734, user_meeting_wages(Date.parse("110")) - 336, user_meeting_wages(Date.parse("110")), user_meeting_wages(Date.parse("140")), user_meeting_wages(Date.parse("160"))]
      }]
    }

    @chart_options_second = {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  end

  def show
    @meeting = Meeting.find(params[:id])
    @start_time = @meeting.start_date - 9.hours
    @end_time = @meeting.end_date - 9.hours
    @booking = @meeting.bookings
    @attendance = @meeting.bookings.map { |booking| booking.user }
    @organizer = User.find(@meeting.user_id)
    @message = Message.new
    @objectives = @meeting.objectives.strip.gsub('Objectives:', '').split("Agenda:")[0].split("\n")
    @agenda = @meeting.objectives.strip.split("Agenda:")[1].split("\n")
    if @meeting.video && @meeting.video.summary
      @summary = @meeting.video.summary.split('.')
      @actions = @meeting.video.actions.split(/\d+\./)[1..-1]
    end
    authorize @meeting

  end

  def new
    @meeting = Meeting.new
    if params[:description] && params[:usersnames]
      @users_names = params[:usersnames].split(",")
      @users = []
      @users_names.each { |name| @users << User.where(name: name).first }
      @next_available_start_date = User.find_available(@users)
      fetch_optimal_duration
      @location = "Room 1"
      @next_available_end_date = @next_available_start_date + Rational(@duration.to_i, 1440)
      fetch_objectives_and_agenda(@next_available_start_date, @next_available_end_date)
      f = ActionView::Helpers::FormBuilder.new(:meeting, @meeting, self, {})
      respond_to do |format|
        format.html
        format.text { render partial: "meeting_result", locals: {
          duration: @duration,
          reason_duration: @reason_duration,
          objectives_and_agenda_text: @objectives_and_agenda_text,
          next_available_start_date: @next_available_start_date,
          next_available_end_date: @next_available_end_date}, formats:[:html] }
      end
    elsif params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
      respond_to do |format|
        format.html
        format.text { render partial: "list", locals: { users: @users_filtered }, formats: [:html] }
      end
    else
      @users_filtered = []
    end
    authorize @meeting
  end

  def create
    @users = []
    @meeting = Meeting.new(meeting_params)
    @duration = ((DateTime.parse(params[:end_date]).to_time - DateTime.parse(params[:start_date]).to_time) / 60).to_i
    @meeting.start_date = DateTime.parse(params[:start_date])
    @meeting.end_date = DateTime.parse(params[:end_date])
    @meeting.duration = @duration
    @meeting.location = "Room 1"
    @meeting.title = get_title_from_chatgpt(params[:meeting][:description])
    @meeting.user = current_user
    @users_names = params[:users]
    authorize @meeting
    Booking.create(user: current_user, meeting: @meeting)
    if @meeting.save
      @users_names.each do |name|
        @user_instance = User.where(name: name).first
        @booking = Booking.create(user: @user_instance, meeting: @meeting)
        @meeting.bookings << @booking
      end
      redirect_to meetings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
    authorize @meeting
    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end
  end

  def update

    @meeting = Meeting.find(params[:id])
    authorize @meeting

    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end

    @meeting.duration = params["meeting"]["duration"]

    if @meeting.update(meeting_params)
      redirect_to meetings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    authorize @meeting
    @meeting.destroy
    redirect_to meetings_path
  end

  private

  def meeting_params
    params.require(:meeting).permit(:status, :user_id, :start_date, :description, :location, :end_date, :title, :objectives)
  end

  def get_title_from_chatgpt(user_reply)
    title_prompt = "Can you please provide a title for a meeting with
      the following description: #{user_reply}.
      Only reply with the answer and should not be more than
      10 words, example reply: 'Training Session for Next Week'"
    OpenaiService.new(title_prompt).call
  end

  def get_objectives_and_agenda_from_chatgpt(description_reply, start_time, end_date)
    objectives_and_agenda_prompt = "Can you please provide a objectives and agenda for a meeting with
      the following description: #{description_reply}.
      Provide only 3 objectives starting from the highest priority to the lowest.
      The meeting starts at #{start_time} and it ends at #{end_date} min should have an itemised date(maximum 5 items).
      reply with bullet points. Your reply should only be the Objectives and Agenda. Agenda should be exactly 4 items. The reply should be in html formal. Example answer:
      Objectives:
        - Highest Priority: Assess the potential benefits and drawbacks of adopting the new accounting software
        - Middle Priority: Assess the potential benefits and drawbacks of adopting the new accounting software
        - Low Priority: Assess the potential benefits and drawbacks of adopting the new accounting software
      Agenda:
        - From 11: 00 to 11:05 Introduction and Welcome (5 minutes)
        - From 11: 05 to 11:15 Review of the New Accounting Software (10 minutes)
        - From 11: 15 to 11:25 Pros and Cons Discussion (10 minutes)
        - From 11: 25 to 11:30 Next Steps and Conclusion (5 minutes)"
    OpenaiService.new(objectives_and_agenda_prompt).call
  end

  def fetch_objectives_and_agenda(next_available_start_date, next_available_end_date)
    @objectives_and_agenda_text = get_objectives_and_agenda_from_chatgpt(
      params[:description],
      next_available_start_date,
      next_available_end_date
    )
    @objectives_and_agenda_text.html_safe
  end

  def get_optimal_time(description_reply, people_reply)
    optimal_time_prompt = "Can you please provide the optimal duration for a meeting with
    the following description: #{description_reply} and number of people: #{people_reply} , based on the following:
    Type of meeting	Number of Attendees	Topic Complexity	Optimal Amount of Time
    Brainstorming	1-4 people	Low	15
    Brainstorming	5-10 people	Low	30
    Brainstorming	1-4 people	High	45
    Brainstorming	5-10 people	High	45
    Decision Making	1-4 people	Low	15
    Decision Making	5-10 people	Low	30
    Decision Making	1-4 people	High	45
    Decision Making	5-10 people	High	45
    Updates	1-4 people	Low	15
    Updates	5-10 people	Low	30
    Updates	1-4 people	High	15
    Updates	5-10 people	High	30
    Team Building	1-4 people	Low	30
    Team Building	5-10 people	Low	30
    Team Building	1-4 people	High	45
    Team Building	5-10 people	High	45
    Training	1-10 people	Low	45
        The reply should be a numbers(minutes) in html formal. Example answer:
    <h3> Optimal time:</h3>
    <p> 30 min </p>
    <h3> Reason:</h3>
    <p> small description </p>"
    OpenaiService.new(optimal_time_prompt).call
  end

  def fetch_optimal_duration
    @duration_text = get_optimal_time(
      params[:description],
      params[:usersnames]
    )
    @matched_duration = @duration_text.match(/\b(\d{2})\smin\b/)
    @matched_reason_duration = @duration_text.match(/<h3> Reason:<\/h3>\s*<p>\s*(.*?)\s*<\/p>/m)
    @reason_duration = @matched_reason_duration[1] if @matched_reason_duration
    @duration = @matched_duration[1] if @matched_duration
    @duration.html_safe
    @reason_duration.html_safe
  end
end
