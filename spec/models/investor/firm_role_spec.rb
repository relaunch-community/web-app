# == Schema Information
#
# Table name: investor_firm_roles
#
#  id                           :uuid             not null, primary key
#  investment_target_customer   :text
#  investment_target_industries :text
#  investment_target_locations  :text
#  investment_target_stage      :text
#  title                        :text
#  why_here                     :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  investor_firm_id             :uuid             not null
#  physical_location_id         :uuid
#  professional_profile_id      :uuid             not null
#
# Indexes
#
#  index_investor_firm_roles_on_investor_firm_id         (investor_firm_id)
#  index_investor_firm_roles_on_physical_location_id     (physical_location_id)
#  index_investor_firm_roles_on_professional_profile_id  (professional_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (investor_firm_id => investor_firms.id)
#  fk_rails_...  (physical_location_id => physical_locations.id)
#  fk_rails_...  (professional_profile_id => professionals_user_profiles.id)
#
require "rails_helper"

RSpec.describe Investor::FirmRole do
  describe "associations" do
    subject(:investor_firm_role) { build(:investor_firm_role, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    it { is_expected.to belong_to(:investor_firm) }
    it { is_expected.to belong_to(:physical_location) }
    it { is_expected.to belong_to(:professional_profile) }
    it { is_expected.to have_many(:versions).class_name("Investor::FirmRoleVersion") }
  end

  describe "attributes" do
    subject(:investor_firm_role) { build(:investor_firm_role, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    describe "title" do
      it { is_expected.to validate_presence_of(:title) }

      it "is a string" do
        expect(investor_firm_role.title).to be_a(String)
      end
    end

    describe "investment_target_locations" do
      it "is a string" do
        expect(investor_firm_role.investment_target_locations).to be_a(String)
      end
    end

    describe "investment_target_stage" do
      it "is a string" do
        expect(investor_firm_role.investment_target_stage).to be_a(String)
      end
    end

    describe "why_here" do
      it "is a string" do
        expect(investor_firm_role.why_here).to be_a(String)
      end
    end
  end

  describe "versioning" do
    subject(:investor_firm_role) { create(:investor_firm_role, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    it "saves a new version" do
      # rubocop:disable Rails/SkipsModelValidations
      expect { investor_firm_role.touch }.to change(investor_firm_role.versions, :count).by(1)
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
