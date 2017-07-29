require 'rails_helper'

RSpec.describe Weight, type: :model do
  describe "#change_from_last_week" do 
    
    it "returns difference between weeks" do
      user = User.create(email: "example@email.com", password: "password")
      7.times do
        Weight.create(date: (Time.now - 1.week), pounds: 100, user_id: user.id)
      end
      7.times do
        Weight.create(date: (Time.now - 2.weeks), pounds: 200, user_id: user.id)
      end
      expect(Weight.change_from_last_week(user)).to eq (- 100)
    end
    
    it "returns correct weight if there are missed days of weighing" do
      user = User.create(email: "example@email.com", password: "password")
      6.times do
        Weight.create(date: (Time.now - 1.week), pounds: 100, user_id: user.id)
      end
      4.times do
        Weight.create(date: (Time.now - 2.weeks), pounds: 200, user_id: user.id)
      end
      expect(Weight.change_from_last_week(user)).to eq (- 100)
    end
    it "weights from other users aren't included in the calculation" do
      user = User.create(email: "example@email.com", password: "password")
      6.times do
        Weight.create(date: (Time.now - 1.week), pounds: 100, user_id: user.id)
      end
      4.times do
        Weight.create(date: (Time.now - 2.weeks), pounds: 200, user_id: user.id)
      end
      user2 = User.create(email: "user2@email.com", password: "password")
      Weight.create(date: (Time.now - 1.week), pounds: 2, user_id: user2.id)
      expect(Weight.change_from_last_week(user)).to eq (- 100)
    end
    
  end

  
end
