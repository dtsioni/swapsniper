require "rails_helper"

feature "Sign up doesn't create duplicate locations" do
  subject{ page }
  scenario "User signs up with unique origin" do
    visit sign_up_path
    @user = FactoryGirl.build(:user)
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Floor", with: "1"

    expect{click_button "Sign up"}.to change(Origin, :count)
    should have_content(@user.full_name)
  end

  scenario "User signs up with preexisting origin" do
    @origin = FactoryGirl.create(:origin, :livingston)
    visit sign_up_path
    @user = FactoryGirl.build(:user)
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Floor", with: "1"
    select "Double - Apartment", from: "Style"

    expect{click_button "Sign up"}.to_not change(Origin, :count)
    should have_content(@user.full_name)
  end
end
