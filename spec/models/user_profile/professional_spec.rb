# == Schema Information
#
# Table name: professionals_user_profiles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hash_id    :uuid
#  user_id    :uuid             not null
#
# Indexes
#
#  index_professionals_user_profiles_on_hash_id  (hash_id) UNIQUE
#  index_professionals_user_profiles_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe UserProfile::Professional do
  describe "associations" do
    subject(:professional_profile) { user.professional_profile }

    let(:user) { create(:user) }

    it { is_expected.to belong_to(:user) }
  end

  describe "attributes" do
    subject(:professional_profile) { user.professional_profile }

    let(:user) { create(:user) }

    describe "hash_id" do
      it "is a uuid" do
        expect(professional_profile.hash_id).to be_a(String)
      end

      it { is_expected.to validate_uniqueness_of(:hash_id).case_insensitive }
    end
  end
end
