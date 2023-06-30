require "rails_helper"

RSpec.describe "user_profile/professionals/new" do
  before do
    assign(:user_profile_professional, UserProfile::Professional.new)
  end

  it "renders new user_profile_professional form" do
    render

    assert_select "form[action=?][method=?]", user_profile_professionals_path, "post" do
    end
  end
end
