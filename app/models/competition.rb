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
  
  def format_for_graph
    user_weights = users.map do |user|
      user.weights.where(date: start_date..end_date ).order(date: :desc)
    end
    u = user_weights.map do |user|
      user.map do |weight|
        starting_weight = starting_weight(weight.user)
        percent = ( weight.pounds - starting_weight )  / starting_weight * 100
        percent.round(1)
        { "user" => weight.user.email,
          "percentage" => percent.round(1),
        "date" => weight.date
        }
      end.group_by{ |i| i["user"] }
    end
    u = u.map {|f| f.values[0] }
  end

  def percent_change(user)
    return unless starting_weight(user) && last_weight(user)
    percent = ( last_weight(user) - starting_weight(user) )  / starting_weight(user) * 100
    percent.round(1)
  end

  private

  def competition_dates
    users.map {|f| f.weights.where(date: start_date..end_date )}.flatten
    .group_by {|f| f.date}.keys.map {|f| f.midnight}.uniq.sort
  end

  def add_nil_values
    percent_hash = percent_changes_all
    dataset = []
    dates = competition_dates.map {|f| f.strftime("%B, %d, %Y") }
    dates.each do |date|
      user = 1
      percent_hash.each do |user_data|
        email = user_data[0]
        dataset << {email => user_data[1][date]}
        user += 1
      end
    end
    dataset
  end

  def percent_changes(user)
    return unless starting_weight(user)
    starting_weight = starting_weight(user)
    user_weights = user.weights.where(date: start_date..end_date ).order(date: :asc)
    hash_of_weights = {}
    user_weights.each do |weight|
      percent = ( weight.pounds - starting_weight ) / starting_weight * 100
      hash_of_weights[weight.date.strftime("%B, %d, %Y")] = percent.round(1)
    end
    hash_of_weights
  end

  def percent_changes_all
    users.map do |user|
      [ user.email, percent_changes(user)]
    end
  end

end
