require "rails_helper"

feature 'enter weight' do
  before(:each) do 
    user = User.create(email: "example@example.com", password: "password")
    sign_in user
  end
  scenario 'enter and submit weight' do
    visit new_weight_path
    fill_in "Pounds", :with => 175.3
    click_button "Submit"
    expect(page).to have_text "175"
  end
  
  scenario 'adjust date of weight' do
    visit new_weight_path
    fill_in "Pounds", :with => 175.3
    find(:css, "#weight_date_3i").find(:option, 10).select_option
    click_button "Submit"
    expect(page).to have_text "10"
  end
  
end