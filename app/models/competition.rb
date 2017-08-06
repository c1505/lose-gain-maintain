class Competition < ApplicationRecord
  belongs_to :host, foreign_key: "user_id", class_name: "User"
  has_many :competitions_users
  has_many :users, through: :competitions_users

  def starting_weight(user)
    user.weights.where(date: start_date..end_date ).order(date: :asc).first.try(:pounds)
  end

  def last_weight(user)
    user.weights.where(date: start_date..end_date ).order(date: :asc).last.try(:pounds)
  end

  def percent_change(user)
    return unless starting_weight(user) && last_weight(user)
    percent = ( last_weight(user) - starting_weight(user) )  / starting_weight(user).round * 100
    percent.round(1)
  end

end
