require "rails_helper"

RSpec.describe "User Registration Sequence" do
  describe "registering in from index page" do
    subject(:current_page) { page }

    before do
      skip("Temporarily disabled registration")
      visit "/"

      within first("section#sign-up-sign-in") do
        click_link(I18n.t("pages.user_signup.signup_link"))
      end
    end

    let(:user_password) { "passwordpassword" }
    let(:user) { build(:user, encrypted_password: Devise::Encryptor.digest(User, user_password)) }

    it { is_expected.to have_selector("h2", text: /join us./i) }

    context "with no user details" do
      before do
        click_button I18n.t("devise.registrations.new.submit")
      end

      it { is_expected.to have_selector("#error-explanation", text: I18n.t("errors.messages.not_saved_header")) }
    end

    context "with mismatching passwords" do
      before do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user_password
        fill_in "user_password_confirmation", with: "#{user_password}+invalid"
        click_button I18n.t("devise.registrations.new.submit")
      end

      it { is_expected.to have_selector("#error-explanation", text: /password confirmation doesn't match password/i) }
    end

    context "with valid details" do
      before do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user_password
        fill_in "user_password_confirmation", with: user_password
        click_button I18n.t("devise.registrations.new.submit")
      end

      it { is_expected.not_to have_selector("#error-explanation") }

      it "redirects to personal profile creation" do
        expect(current_page).to have_current_path("/profile/personal/new")
      end
    end
  end
end
