# == Schema Information
#
# Table name: investor_firms
#
#  id                      :uuid             not null, primary key
#  name                    :text
#  overview                :text
#  site_url                :text
#  slug                    :text
#  thesis                  :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  physical_location_id    :bigint
#  professional_profile_id :bigint
#
# Indexes
#
#  index_investor_firms_on_name                     (name) UNIQUE
#  index_investor_firms_on_physical_location_id     (physical_location_id)
#  index_investor_firms_on_professional_profile_id  (professional_profile_id)
#  index_investor_firms_on_slug                     (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (professional_profile_id => professionals_user_profiles.id)
#
require "rails_helper"

RSpec.describe Investor::Firm do
  describe "associations" do
    subject(:investor_firm) { build(:investor_firm, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    it { is_expected.to have_many(:investor_firm_roles).with_foreign_key("investor_firm_id") }
    it { is_expected.to belong_to(:physical_location) }
    it { is_expected.to belong_to(:professional_profile) }
  end

  describe "attributes" do
    subject(:investor_firm) { create(:investor_firm) }

    describe "name" do
      it { is_expected.to validate_presence_of(:name) }

      it "is a string" do
        expect(investor_firm.name).to be_a(String)
      end

      it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    end

    describe "overview" do
      it "is a string" do
        expect(investor_firm.overview).to be_a(String)
      end
    end

    describe "site_url" do
      it { is_expected.to validate_presence_of(:site_url) }

      it "is a string" do
        expect(investor_firm.site_url).to be_a(String)
      end
    end

    describe "slug" do
      it "is a string" do
        expect(investor_firm.slug).to be_a(String)
      end
    end

    describe "thesis" do
      it "is a string" do
        expect(investor_firm.thesis).to be_a(String)
      end
    end
  end
end
