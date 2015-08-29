require "spec_helper"

describe "User goes to matches page" do
  subject{ page }
  before do
    @user = FactoryGirl.create(:user, :male)

    visit sign_in_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    @user.origin = FactoryGirl.create(:origin)
    @user.destination = FactoryGirl.create(:destination)

    click_button "Sign in"
  end

  it{ should have_content("no matches") }
end
