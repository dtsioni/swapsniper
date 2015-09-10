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

  scenario "User wants to live in any building" do
    @user.destination = FactoryGirl.create(:destination, :busch, building: "anywhere")
    @user.save
    @match = FactoryGirl.create(:user)
    @match.origin = FactoryGirl.create(:origin, :busch, building: "not a perfect match")
    @match.destination = FactoryGirl.create(:destination, :livingston)
    @match.save

    visit root_path

    should have_content(@match.full_name_last_initial)
  end

  scenario "User matches with someone who wants to live in any building" do
    @campus_match = FactoryGirl.create(:user)
    @campus_match.origin = FactoryGirl.create(:origin, :busch)
    @campus_match.destination = FactoryGirl.create(:destination, :livingston, building: "anywhere")
    @campus_match.save

    visit root_path

    should have_content(@campus_match.full_name_last_initial)
  end

  scenario "User wants to live in any building and so does their match" do
    @user.origin = FactoryGirl.create(:origin, :livingston, building: "not a perfect match")
    @user.destination = FactoryGirl.create(:destination, :busch, building: "anywhere")
    @user.save
    @match = FactoryGirl.create(:user)
    @match.origin = FactoryGirl.create(:origin, :busch, building: "not a perfect match")
    @match.destination = FactoryGirl.create(:destination, :livingston, building: "anywhere")
    @match.save

    visit root_path

    should have_content(@match.full_name_last_initial)
  end
end
