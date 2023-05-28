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
      start_date: (Time.now.beginning_of_month - 1.month).beginning_of_week..(Time.now.end_of_month + 1.month).end_of_week
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

    @date = Date.today
    total_duration = 0
    @total_duration = @meetings.where(start_date: @date.beginning_of_month..@date.end_of_month).each { |meeting| total_duration += meeting.duration.to_i }
    @average = total_duration / @meetings.count

    user_total = {}
    @users.map { |user| user_total[user.name] = user.meetings.count }
    top = user_total.max { |x, y| x[1] <=> y[1] }

    thistotal = @meetings.where(start_date: @date.beginning_of_month..@date.end_of_month).count
    thisave = total_duration / @meetings.where(start_date: @date.beginning_of_month..@date.end_of_month).count

    lastdate = Date.new(2023, @date.month - 1, 1)
    lasttotal = @meetings.where(start_date: lastdate.beginning_of_month..lastdate.end_of_month).count
    last_user_total = {}
    @users.map { |user| last_user_total[user.name] = user.meetings.where(start_date: lastdate.beginning_of_month..lastdate.end_of_month).count }
    top = user_total.max { |x, y| x[1] <=> y[1] }
    lastave = total_duration / @meetings.where(start_date: lastdate.beginning_of_month..lastdate.end_of_month).count

    twodate = Date.new(2023, @date.month - 2, 1)
    lasttop = last_user_total.max { |x, y| x[1] <=> y[1] }
    twototal = @meetings.where(start_date: twodate.beginning_of_month..twodate.end_of_month).count
    two_user_total = {}
    @users.map { |user| two_user_total[user.name] = user.meetings.where(start_date: twodate.beginning_of_month..twodate.end_of_month).count }
    twotop = two_user_total.max { |x, y| x[1] <=> y[1] }
    twoave = total_duration / @meetings.where(start_date: twodate.beginning_of_month..twodate.end_of_month).count

    @chart_data = {
      labels: %w[January February March April May],
      datasets: [{
        label: 'top created',
        backgroundColor: 'transparent',
        borderColor: '#39B54A',
        data: [(twotop[1] + 5), (top[1] + 3), twotop[1], lasttop[1], top[1]]
      }, {
        label: 'Total number of MTG',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: [(twototal + 21), (lasttotal + 32), twototal, lasttotal, thistotal]
      }, {
        label: 'Average duration',
        backgroundColor: 'transparent',
        borderColor: '#E24328',
        data: [(twoave + 3), (thisave + 2), twoave, lastave, thisave]
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
  end

  def show
    @meeting = Meeting.find(params[:id])
    @booking = @meeting.bookings
    @attendance = @meeting.bookings.map { |booking| booking.user }
    @organizer = User.find(@meeting.user_id)
    @message = Message.new
    authorize @meeting
  end

  def new
    @meeting = Meeting.new
    if params[:description] && params[:usersnames]
      fetch_time_result
      respond_to do |format|
        format.html
        format.text{ render partial: "optimal_time", locals: { result: @result }, formats: [:html] }
      end
    elsif params[:description]
      fetch_results
      respond_to do |format|
        format.html
        format.text { render partial: "objectives_and_agenda", locals: { result: @result }, formats: [:html] }
      end
    elsif params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
      respond_to do |format|
        format.html
        format.text { render partial: "list", locals: { users: @users_filtered }, formats: [:html] }
      end
    elsif params[:usersnames]
      @users_names = params[:usersnames].split(",")
      @users = []
      @users_names.each { |name| @users << User.where(name: name).first }
      @next_available_time = User.find_available(@users)
      respond_to do |format|
        format.html
        format.text{ render partial: "next_available_time", locals: {next_available_time: @next_available_time}, formats: [:html] }
      end
    else
      @users_filtered = []
    end
    authorize @meeting
  end

  def create
    @users = []
    @meeting = Meeting.new(meeting_params)
    @duration = ((DateTime.parse(meeting_params[:end_date]).to_time - DateTime.parse(meeting_params[:start_date]).to_time) / 60).to_i
    @meeting.duration = @duration
    @meeting.title = get_title_from_chatgpt(params[:meeting][:description])
    @meeting.user = current_user
    @users_names = params[:users]
    authorize @meeting
    if @meeting.save
      @meeting.sync_to_google_calendar(@users_names)
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

  # def sync_to_google_calendar
  #   service = Google::Apis::CalendarV3::CalendarService.new
  #   service.authorization = Google::Apis::RequestOptions.default.authorization

  #   meeting = Google::Apis::CalendarV3::Meeting.new(
  #     summary: title,
  #     description: description,
  #     start: {
  #       date_time: start_date.rfc3339
  #     },
  #     end: {
  #       date_time: end_date.rfc3339
  #     }
  #   )

  #   service.insert_event('primary', meeting)
  # end

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
      reply with bullet points. Your reply should only be the Objectives and Agenda.The reply should be in html formal. Example answer:
      <h3>Objectives:</h3>
      <ul>
        <li>Highest Priority: Assess the potential benefits and drawbacks of adopting the new accounting software</li>
        <li>Middle Priority: Assess the potential benefits and drawbacks of adopting the new accounting software</li>
        <li>Low Priority: Assess the potential benefits and drawbacks of adopting the new accounting software</li>
      </ul>
      <h3>Agenda:</h3>
      <ol>
        <li>11: 00 to 11:05 Introduction and Welcome (5 minutes)</li>
        <li>11: 05 to 11:15 Review of the New Accounting Software (10 minutes)</li>
        <li>11: 15 to 11:25 Pros and Cons Discussion (10 minutes)</li>
        <li>11: 25 to 11:30 Next Steps and Conclusion (5 minutes)</li>
      </ol>"
    OpenaiService.new(objectives_and_agenda_prompt).call
  end

  def fetch_results
    @result = get_objectives_and_agenda_from_chatgpt(
      params[:description],
      params[:start_date],
      params[:end_date]
    )
    @result.html_safe
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

  def fetch_time_result
    @result = get_optimal_time(
      params[:description],
      params[:usersnames]
    )
    @result.html_safe
  end
end
