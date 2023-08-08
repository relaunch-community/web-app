# == Schema Information
#
# Table name: professionals_user_profiles
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
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
    it { is_expected.to have_many(:versions).class_name("UserProfile::ProfessionalVersion") }
  end

  describe "versioning" do
    subject(:professional_profile) { user.professional_profile }

    let(:user) { create(:user) }

    it "saves a new version" do
      # rubocop:disable Rails/SkipsModelValidations
      expect { professional_profile.touch }.to change(professional_profile.versions, :count).by(1)
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
