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

  scenario "With the same Origin" do
    #origin by default is livingston apartments, livingston
    select "Livingston", from: "user_origin_attributes_campus"
    select "Livingston Apartments", from: "user_origin_attributes_building"
    select "Cook/Douglass", from: "user_destination_attributes_campus"

    expect{click_button "Update User"}.to_not change(Origin, :count)
    expect(page).to have_content("success")
    expect(page).to have_content("Cook/Douglass") #destination was busch, this tests that the user was updated
  end
end

