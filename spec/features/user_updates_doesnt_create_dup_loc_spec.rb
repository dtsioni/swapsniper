require "rails_helper"

feature "User updates their information" do
  before do
    @user = FactoryGirl.create(:user)
    @user.origin = FactoryGirl.create(:origin, :livingston)
    @user.destination = FactoryGirl.create(:destination, :busch)
    @user.save
    visit sign_in_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign in"
    visit edit_user_path(@user)
  end

  scenario "Origin isn't duplicated when they update to the same Origin" do
    select "Livingston", from: "user_origin_attributes_campus" #make origin the same
    select "Livingston Apartments", from: "user_origin_attributes_building"
    fill_in "Floor", with: "1"
    select "Double - Apartment", from: "user_origin_attributes_style"
    select "Cook/Douglass", from: "user_destination_attributes_campus" #make destination different

    expect{click_button "Update User"}.to_not change(Origin, :count)
    expect(page).to have_content("success")
    expect(page).to have_content("Cook/Douglass") #destination was originally busch, this tests that the user was updated
  end
end

