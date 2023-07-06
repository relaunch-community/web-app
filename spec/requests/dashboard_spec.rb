require "rails_helper"

RSpec.describe "Dashboards" do
  describe "GET /show without a personal profile" do
    let(:user) { create(:user) }

    before do
      # https://stackoverflow.com/questions/10121835/how-do-i-simulate-a-login-with-rspec
      # https://stackoverflow.com/questions/27284657/undefined-method-env-for-nilnilclass-in-setup-controller-for-warden-error
      login_as user
    end

    it "redirects to the new personal profile form" do
      get dashboard_url
      expect(response).to redirect_to(new_user_profile_personal_url)
    end
  end

  describe "GET /show with a personal profile, without a professional profile" do
    let(:user) { create(:user_with_personal_profile) }

    before do
      # https://stackoverflow.com/questions/10121835/how-do-i-simulate-a-login-with-rspec
      # https://stackoverflow.com/questions/27284657/undefined-method-env-for-nilnilclass-in-setup-controller-for-warden-error
      login_as user
    end

    it "redirects to the new professional profile form" do
      get dashboard_url
      expect(response).to redirect_to(user_profile_professional_url(user.professional_profile))
    end
  end
end
