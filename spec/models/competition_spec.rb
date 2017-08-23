require 'rails_helper'

RSpec.describe Competition, type: :model do
  describe "#starting_weight" do
    it "returns starting weight" do
      competition = Competition.new(start_date: Time.current, end_date: Time.current + 10.days)
      user = User.create(email: "email@email.com", password: "password")
      weight_1 = Weight.new(pounds: 170, date: Time.current)
      weight_2 = Weight.new(pounds: 169, date: Time.current - 2.days)
      weight_3 = Weight.new(pounds: 168, date: Time.current - 1.day)
      user.weights = [weight_1, weight_2, weight_3]
      expect( competition.starting_weight(user) ).to eq (170)
    end
    it "returns starting weight when the date is not today" do
      competition = Competition.new(start_date: Time.current - 1.day, end_date: Time.current + 10.days)
      user = User.create(email: "email@email.com", password: "password")
      weight_1 = Weight.new(pounds: 170, date: Time.current)
      weight_2 = Weight.new(pounds: 169, date: Time.current - 2.days)
      weight_3 = Weight.new(pounds: 168, date: Time.current - 1.day)
      user.weights = [weight_1, weight_2, weight_3]
      expect( competition.starting_weight(user) ).to eq (168)
    end
  end
  describe "#last_weight" do
    it "returns last weight" do
      competition = Competition.new(start_date: Time.current - 10.days, end_date: Time.current + 10.days)
      user = User.create(email: "email@email.com", password: "password")
      weight_1 = Weight.new(pounds: 170, date: Time.current)
      weight_2 = Weight.new(pounds: 169, date: Time.current - 2.days)
      weight_3 = Weight.new(pounds: 168, date: Time.current - 1.day)
      user.weights = [weight_1, weight_2, weight_3]
      expect( competition.last_weight(user) ).to eq (170)
    end

    it "returns last competition weight after competition has ended" do
      competition = Competition.new(start_date: Time.current - 10.days, end_date: Time.current + 5.minutes)
      user = User.create(email: "email@email.com", password: "password")
      weight_1 = Weight.new(pounds: 170, date: Time.current)
      weight_2 = Weight.new(pounds: 169, date: Time.current - 2.days)
      weight_3 = Weight.new(pounds: 168, date: Time.current - 1.day)
      weight_4 = Weight.new(pounds: 160, date: Time.current + 1.day)
      user.weights = [weight_1, weight_2, weight_3, weight_4]
      expect( competition.last_weight(user) ).to eq (170)
    end
  end
  describe "percent_change" do
    it "returns the percent change from starting to ending weight" do
      competition = Competition.new(start_date: Time.current - 10.days, end_date: Time.current + 5.minutes)
      user = User.create(email: "email@email.com", password: "password")
      weight_1 = Weight.new(pounds: 170, date: Time.current)
      weight_2 = Weight.new(pounds: 169, date: Time.current - 2.days)
      weight_3 = Weight.new(pounds: 168, date: Time.current - 1.day)
      user.weights = [weight_1, weight_2, weight_3]
      expect( competition.percent_change(user) ).to eq (0.6)
    end
  end
  
  describe "percent_changes" do #Delete if failing and not useful in refactoring
    it "returns the percent change from the start weight at each time point" do
      competition = Competition.new(start_date: Time.current - 10.days, end_date: Time.current + 5.minutes)
      user = User.create(email: "email@email.com", password: "password")
      date_3 = Time.current.midnight
      date_1 = date_3 - 2.days
      date_2 = date_3 - 1.day
      weight_1 = Weight.new(pounds: 169, date: date_1)
      weight_2 = Weight.new(pounds: 168, date: date_2)
      weight_3 = Weight.new(pounds: 170, date: date_3)
      user.weights = [weight_1, weight_2, weight_3]
      expect( competition.send(:percent_changes, user) ).to eq ({
        date_1.strftime("%B, %d, %Y")=> 0.0,
        date_2.strftime("%B, %d, %Y")=> -0.6,
        date_3.strftime("%B, %d, %Y")=> 0.6,
      })
    end
  end
  
  describe "percent_changes_all" do #Can delete if failing.  
    it "returns the percent change from the start weight at each time point" do
      competition = Competition.new(start_date: Time.current - 10.days, end_date: Time.current + 5.minutes)
      user_1 = User.create(email: "email@email.com", password: "password")
      user_2 = User.create(email: "email2@email.com", password: "password")
      competition.users = [user_1, user_2]
      date_3 = Time.current.midnight
      date_1 = date_3 - 2.days
      date_2 = date_3 - 1.day
      date_4 = date_3 - 3.days
      weight_1 = Weight.new(pounds: 169, date: date_1)
      weight_2 = Weight.new(pounds: 168, date: date_2)
      weight_3 = Weight.new(pounds: 170, date: date_3)
      weight_4 = Weight.new(pounds: 169, date: date_1)
      weight_5 = Weight.new(pounds: 168, date: date_2)
      weight_6 = Weight.new(pounds: 170, date: date_4)
      user_1.weights = [weight_1, weight_2, weight_3]
      user_2.weights = [weight_6, weight_4, weight_5]
      
      expect( competition.send(:percent_changes_all) ).to eq ([ 
        [ "email@email.com", 
          { 
            date_1.strftime("%B, %d, %Y")=> 0.0,
            date_2.strftime("%B, %d, %Y")=> -0.6,
            date_3.strftime("%B, %d, %Y")=> 0.6,
          }
        ],
        [ "email2@email.com", 
          { 
            date_4.strftime("%B, %d, %Y")=> 0.0,
            date_1.strftime("%B, %d, %Y")=> -0.6,
            date_2.strftime("%B, %d, %Y")=> -1.2,
          }
        ]
      ])
    end
  end
  describe "format for chart" do 
    it "groupes by date and fills in null values where no percent exist for a given date" do 
      competition = Competition.new(start_date: Time.current - 10.days, end_date: Time.current + 5.minutes)
      user_1 = User.create(email: "email@email.com", password: "password")
      user_2 = User.create(email: "email2@email.com", password: "password")
      competition.users = [user_1, user_2]
      date_3 = Time.current.midnight
      date_1 = date_3 - 2.days
      date_2 = date_3 - 1.day
      date_4 = date_3 - 3.days
      weight_1 = Weight.new(pounds: 169, date: date_1)
      weight_2 = Weight.new(pounds: 168, date: date_2)
      weight_3 = Weight.new(pounds: 170, date: date_3)
      weight_4 = Weight.new(pounds: 169, date: date_1)
      weight_5 = Weight.new(pounds: 168, date: date_2)
      weight_6 = Weight.new(pounds: 170, date: date_4)
      user_1.weights = [weight_1, weight_2, weight_3]
      user_2.weights = [weight_6, weight_4, weight_5]
      
      expect( competition.format_for_graph ).to eq (
        {
          "dates": [date_4, date_1, date_2, date_3 ],
          "datasets": [{"email@email.com"=>[nil, 0.0, -0.6, 0.6]}, {"email2@email.com"=>[0.0, -0.6, -1.2, nil]}]
        }
      )
    end
  end
end
