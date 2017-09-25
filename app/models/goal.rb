class Goal < ApplicationRecord
  belongs_to :user
  
  def weekly_target_change
    last_7_days_average =  Weight.average(7, user).round(1)
    time_for_change = target_date - Time.current
    time_for_change = to_weeks(time_for_change)
    total = (weight - last_7_days_average) / time_for_change
    total.round(2)
  end
  
  private
  def to_weeks(seconds)
    seconds / 60 / 60 / 24 / 7
  end
end