require "rails_helper"

feature 'competition' do
  before(:each) do 
    user = User.create(email: "example@example.com", password: "password")
    sign_in user
  end
  scenario 'new competition' do
    visit new_competition_path
    click_button "Submit"
    expect(page).to have_current_path(competition_path(Competition.last.id))
  end
end