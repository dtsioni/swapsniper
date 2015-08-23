require "spec_helper"

describe "User goes to matches page" do
  before do
    @user = FactoryGirl.build(:user, :male)

    visit sign_in_path

    fill_in :first_name, with: @user.first_name
    fill_in :last_name, with: @user.last_name
  end
end
