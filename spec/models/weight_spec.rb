require 'rails_helper'

RSpec.describe Weight, type: :model do
  describe "#change_from_last_week" do 
    
    it "returns difference between weeks" do
      7.times do
        Weight.create(date: (Time.now - 1.week), pounds: 100)
      end
      7.times do
        Weight.create(date: (Time.now - 2.weeks), pounds: 200)
      end
      expect(Weight.change_from_last_week).to eq (- 100)
    end
    
    it "returns correct weight if there are missed days of weighing" do
      6.times do
        Weight.create(date: (Time.now - 1.week), pounds: 100)
      end
      4.times do
        Weight.create(date: (Time.now - 2.weeks), pounds: 200)
      end
      expect(Weight.change_from_last_week).to eq (- 100)
    end
    it "does something" do
    end
    
  end

  
end
