require "rails_helper"

describe "User goes to matches page" do
  subject{ page }
  before do
    @user = FactoryGirl.create(:user)
    visit sign_in_path
  end
  it{ should have_content(@user.full_name) }
end
