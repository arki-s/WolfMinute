module ApplicationHelper

  def available_time
    time_check = ["9~10", "10~11", "11~12", "12~13", "13~14", "14~15", "15~16", "16~17", "17~18"]
    avatime = []
    user1 = User.first
    user2 = User.second

    date = Date.today + 1
    bisstart = Time.local(date.year, )
    bisend = Time.local(date.year, )
    duration = 1 ~



    date.between?(bisstart, bisend)
    # or .cover?

    date.saturday?
    date.sunday?



    # in the first place we dont have the method to add multiple attendees to the meeting??

    # meetings has start_date(with_time) and duration
    # select users as array
    # set business hour (9~18 on weekday only)
    # set duration
    # calculate available time for each users with(substruct like bishour - meeting time?)
    # find each users available time with comparing each available time

# using loop?
#  from tomorrow calculate until finding available time



  end




end
