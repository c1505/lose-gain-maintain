class Competition < ApplicationRecord
  belongs_to :user
  has_many :competitions_users
  has_many :users, through: :competitions_users
end
