class Weight < ApplicationRecord
  belongs_to :user
  has_many :competitions
  
  def self.average(days, user)
    weights = Weight.where(date: (Time.current.midnight - days.days).. Time.current, user_id: user.id)
    if weights.blank?
      0
    else
      weights.map {|weight| weight.pounds }.reduce(:+) / weights.count
    end
  end
  
  def self.change_from_last_week(user)
    last_7 = Weight.average(7, user)
    previous_7 = Weight.where(date: (Time.current.midnight - 14.days).. Time.current.midnight - 7.days, user_id: user.id)
    if previous_7.blank? || last_7.blank?
      0
    else
      previous_7 = previous_7.map {|weight| weight.pounds }.reduce(:+) / previous_7.count
      last_7 - previous_7
    end
  end
  
  def self.initial_weight(days)
    Weight.order(date: :desc).limit(days).map {|weight| weight.pounds }.reduce(:+) / days
  end
  
end
