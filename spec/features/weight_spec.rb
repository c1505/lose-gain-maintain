require "rails_helper"

feature 'enter weight' do
  scenario 'enter and submit weight' do
    visit new_weight_path
  end
end