require "rails_helper"

feature 'enter weight' do
  scenario 'enter and submit weight' do
    visit new_weight_path
    fill_in "Pounds", :with => 175.3
    click_button "Submit"
    expect(page).to have_text "175"
  end
end