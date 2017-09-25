require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe "#weekly_target_change" do
    it "returns weekly target change" do
      goal = Goal.new(weight: 170, start_date: Time.current, target_date: Time.current + 14.days)
      user = User.create(email: "email@email.com", password: "password")
      weight_1 = Weight.new(pounds: 171, date: Time.current)
      weight_2 = Weight.new(pounds: 171, date: Time.current - 2.days)
      weight_3 = Weight.new(pounds: 171, date: Time.current - 1.day)
      user.weights = [weight_1, weight_2, weight_3]
      user.goals << goal
      
      expect(goal.weekly_target_change).to eq -0.5
    end
  end
end
