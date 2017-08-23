class Weight < ApplicationRecord
  belongs_to :user
  has_many :competitions
  
  def self.average(days, user)
    weights = self.weights(days, user)
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
  
  def self.weights(days, user)
    Weight.where(date: (Time.current.midnight - days.days).. Time.current, user_id: user.id)
  end
  
  def self.weekly_slope(user)
    weights = self.weights(7, user).reverse
    return 0 if weights.blank?
    first_weight_date = weights.first.date
    days = weights.map do |weight|
      time_in_seconds = weight.date - first_weight_date
      time_in_seconds / 60 / 60 / 24
    end
    regression = SimpleLinearRegression.new(days, weights.map {|weight| weight.pounds})
    regression.slope * 7
  end
  
end
