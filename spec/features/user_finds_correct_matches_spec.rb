require "rails_helper"

feature "User goes to matches page" do
  subject{ page }
  before do
    @user = FactoryGirl.create(:user)
    @user.origin = FactoryGirl.create(:origin, :livingston)
    @user.destination = FactoryGirl.create(:destination, :busch)
    @user.save
    visit sign_in_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign in"
  end

  it{ should have_content("No matches") }

  scenario "User has an exact match" do
    @perfect_match = FactoryGirl.create(:user)
    @perfect_match.origin = FactoryGirl.create(:origin, :busch)
    @perfect_match.destination = FactoryGirl.create(:destination, :livingston)
    @perfect_match.save

    visit root_path

    should have_content(@perfect_match.full_name_last_initial)
  end
end
