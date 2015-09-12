require "rails_helper"

feature "User tries to sign in" do
  subject{ page }
  scenario "Before user signs in" do
    visit root_path
    should have_content("Sign In")
    should have_content("Sign Up")
  end

  scenario "User signs in" do
    @user = FactoryGirl.create(:user)
    @user.origin = FactoryGirl.create(:origin, :busch)
    @user.destination = FactoryGirl.create(:destination, :livingston)
    @user.save
    visit sign_in_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Sign in"

    should have_content(@user.full_name)
    should have_content("Sign Out")
  end
end
