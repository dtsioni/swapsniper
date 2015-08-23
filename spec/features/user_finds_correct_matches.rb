require "spec_helper"

describe "User goes to matches page" do
  before do
    @user = FactoryGirl.create(:user, :male)

    visit sign_in_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
  end
end
