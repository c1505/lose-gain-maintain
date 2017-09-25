class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :weights
  has_many :competitions_users
  has_many :competitions, through: :competitions_users
  has_many :goals
  
  def truncated_email
    email.split("@")[0]
  end
end
