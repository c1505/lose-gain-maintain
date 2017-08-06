class Competition < ApplicationRecord
  belongs_to :host, foreign_key: "user_id", class_name: "User"
  has_many :competitions_users
  has_many :users, through: :competitions_users
end
