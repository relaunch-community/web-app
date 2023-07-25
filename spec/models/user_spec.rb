# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  roles_mask             :integer
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_roles_mask            (roles_mask)
#
require "rails_helper"

RSpec.describe User do
  describe "associations" do
    subject(:user) { described_class.new }

    it { is_expected.to have_one(:professional_profile) }
  end

  describe "id" do
    subject { create(:user) }

    it { is_expected.to have_attributes(id: an_object_satisfying("a valid uuid") { |id| UUID.validate(id) }) }
  end

  describe "email" do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to have_encrypted_attribute(:email) }

    context "when creating a user with a duplicate email address" do
      let(:user_original) { subject }
      let(:user_dup) { user_original.deep_dup }

      it { expect(user_original).to be_persisted }
      it { expect { user_dup.save! }.to raise_error(ActiveRecord::RecordInvalid, /Email has already been taken/) }
    end
  end

  describe "attribute password" do
    it { is_expected.to validate_presence_of(:password) }
  end
end
