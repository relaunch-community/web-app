require "rails_helper"

RSpec.describe "User Login Sequence" do
  context "when not logged in" do
    subject { page }

    before do
      visit "/"
    end

    it { is_expected.to have_selector("section", id: "sign-up") }
    it { is_expected.to have_link(I18n.t("pages.user_signup.signup_link"), href: new_user_registration_path) }
  end

  describe "logging in from index page" do
    subject { page }

    let(:user_password) { "passwordpassword" }
    let(:user) { create(:user, encrypted_password: Devise::Encryptor.digest(User, user_password)) }

    before do
      visit "/"

      within first("section#sign-up") do
        click_link(I18n.t("pages.user_signup.signup_link"))
      end

      click_link("Log in")
    end

    it { is_expected.to have_selector("h2", text: /welcome back, friend./i) }

    context "with no login details" do
      before do
        click_button "Log in"
      end

      it { is_expected.to have_selector("#error-explanation", text: /invalid email or password/i) }
    end

    context "with invalid login details" do
      before do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: "#{user_password}+invalid"
        click_button "Log in"
      end

      it { is_expected.to have_selector("#error-explanation", text: /invalid email or password/i) }
    end

    context "with correct login details" do
      before do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user_password
        click_button "Log in"
      end

      it { is_expected.not_to have_selector("#error-explanation", text: /invalid email or password/i) }
    end
  end
end
