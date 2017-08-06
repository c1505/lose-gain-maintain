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
end
