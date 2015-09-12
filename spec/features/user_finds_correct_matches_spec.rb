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
    @user.origin = FactoryGirl.create(:origin, :livingston, building: "not a perfect match")
    @user.save
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

  scenario "User picks their own origin as their destination" do
    @user.destination = FactoryGirl.create(:destination, :livingston)
    @user.save

    visit root_path

    should_not have_content(@user.full_name_last_initial)
  end

  scenario "User doesn't match with non matching users" do
    #this user will match with their origin but not destination
    @non_match_1 = FactoryGirl.create(:user)
    @non_match_1.origin = FactoryGirl.create(:origin, :busch)
    @non_match_1.destination = FactoryGirl.create(:destination, :cookdouglass)
    @non_match_1.save
    #this user will match with their destination but not origin
    @non_match_2 = FactoryGirl.create(:user)
    @non_match_2.origin = FactoryGirl.create(:origin, :cookdouglass)
    @non_match_2.destination = FactoryGirl.create(:destination, :livingston)
    @non_match_2.save
    #this user won't match at all
    @non_match_3 = FactoryGirl.create(:user)
    @non_match_3.origin = FactoryGirl.create(:origin, :cookdouglass)
    @non_match_3.destination = FactoryGirl.create(:destination, :cookdouglass)
    @non_match_3.save

    visit root_path

    should_not have_content(@non_match_1.full_name_last_initial)
    should_not have_content(@non_match_2.full_name_last_initial)
    should_not have_content(@non_match_3.full_name_last_initial)
  end

  scenario "User doesn't match with different gender" do
    @different_gender = FactoryGirl.create(:user, :female)
    @different_gender.origin = FactoryGirl.create(:origin, :busch)
    @different_gender.destination = FactoryGirl.create(:destination, :livingston)
    @different_gender.save

    visit root_path

    should_not have_content(@different_gender.full_name_last_initial)
  end

  scenario "User wants to live on any campus" do
    @user.destination = FactoryGirl.create(:destination, :anycampus)
    @user.save
    @busch_match = FactoryGirl.create(:user)
    @busch_match.origin = FactoryGirl.create(:origin, :busch)
    @busch_match.destination = FactoryGirl.create(:destination, :livingston)
    @busch_match.save
    @cd_match = FactoryGirl.create(:user)
    @cd_match.origin = FactoryGirl.create(:origin, :cookdouglass)
    @cd_match.destination = FactoryGirl.create(:destination, :livingston)
    @cd_match.save
    @non_match = FactoryGirl.create(:user)
    @non_match.origin = FactoryGirl.create(:origin, :busch)
    @non_match.destination = FactoryGirl.create(:destination, :cookdouglass)
    @non_match.save

    visit root_path

    should have_content(@busch_match.full_name_last_initial)
    should have_content(@cd_match.full_name_last_initial)
    should_not have_content(@non_match.full_name_last_initial)
  end

  scenario "User matches with a user who wants to live on any campus" do
    @any_campus_match = FactoryGirl.create(:user)
    @any_campus_match.origin = FactoryGirl.create(:origin, :busch)
    @any_campus_match.destination = FactoryGirl.create(:destination, :anycampus)
    @any_campus_match.save

    visit root_path

    should have_content(@any_campus_match.full_name_last_initial)
  end
end
