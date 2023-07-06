require "rails_helper"

RSpec.describe "user_profile/personals/edit" do
  let(:user_profile_personal) {
    create(:user_profile_personal)
  }

  before do
    assign(:user_profile_personal, user_profile_personal)
  end

  it "renders the edit user_profile_personal form" do
    render

    assert_select "form[action=?][method=?]", user_profile_personal_path(user_profile_personal), "post" do
    end
  end
end
