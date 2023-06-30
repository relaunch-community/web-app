require "rails_helper"

RSpec.describe "user_profile/professionals/edit" do
  let(:user_profile_professional) {
    create(:user_profile_professional)
  }

  before do
    assign(:user_profile_professional, user_profile_professional)
  end

  it "renders the edit user_profile_professional form" do
    render

    assert_select "form[action=?][method=?]", user_profile_professional_path(user_profile_professional), "post" do
    end
  end
end
