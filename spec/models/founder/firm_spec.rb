# == Schema Information
#
# Table name: founder_firms
#
#  id                        :uuid             not null, primary key
#  ended_on                  :datetime
#  field_visibility          :json
#  firm_kind                 :integer          not null
#  firm_kind_justification   :text
#  founded_at                :datetime
#  long_description          :text
#  name                      :string           not null
#  review_state              :string
#  short_description         :text             not null
#  site_url                  :text
#  slug                      :text
#  target_customer           :string
#  target_industries         :string
#  target_locations          :string
#  target_problem            :text             not null
#  visibility                :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  headquarters_location_id  :bigint
#  incorporation_location_id :bigint
#  professional_profile_id   :bigint
#
# Indexes
#
#  index_founder_firms_on_headquarters_location_id   (headquarters_location_id)
#  index_founder_firms_on_incorporation_location_id  (incorporation_location_id)
#  index_founder_firms_on_name                       (name) UNIQUE
#  index_founder_firms_on_professional_profile_id    (professional_profile_id)
#  index_founder_firms_on_review_state               (review_state)
#  index_founder_firms_on_slug                       (slug) UNIQUE
#  index_founder_firms_on_visibility                 (visibility)
#
# Foreign Keys
#
#  fk_rails_...  (headquarters_location_id => physical_locations.id)
#  fk_rails_...  (incorporation_location_id => physical_locations.id)
#  fk_rails_...  (professional_profile_id => professionals_user_profiles.id)
#
require "rails_helper"

RSpec.describe Founder::Firm do
  describe "associations" do
    subject(:founder_firm) { build(:founder_firm, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    it { is_expected.to belong_to(:headquarters_location) }
    it { is_expected.to belong_to(:incorporation_location).optional(true) }
    it { is_expected.to have_many(:founder_firm_roles) }
    it { is_expected.to belong_to(:professional_profile) }
  end

  describe "attributes" do
    subject(:founder_firm) { build(:founder_firm) }

    describe "name" do
      it { is_expected.to validate_presence_of(:name) }

      it "is a string" do
        expect(founder_firm.name).to be_a(String)
      end
    end

    describe "founded_at" do
      it { expect(founder_firm).to have_db_column(:founded_at).of_type(:datetime) }
    end

    describe "ended_on" do
      it { expect(founder_firm).to have_db_column(:ended_on).of_type(:datetime) }
    end

    describe "visibility" do
      it { expect(founder_firm).to have_db_column(:visibility).of_type(:integer) }

      it do
        expect(founder_firm)
          .to(
            define_enum_for(:visibility)
              .with_values(["Public", "Internal (members-only)", "Private (admins-only)"])
          )
      end
    end

    describe "field_visibility" do
      it { expect(founder_firm).to have_db_column(:field_visibility).of_type(:json) }
    end

    describe "firm_kind" do
      it { is_expected.to validate_presence_of(:firm_kind) }
      it { expect(founder_firm).to have_db_column(:firm_kind).of_type(:integer) }

      it do
        expect(founder_firm)
          .to(
            define_enum_for(:firm_kind)
              .with_values(["Startup", "Small Business", "Enterprise", "Agency", "Nonprofit", "Other"])
          )
      end
    end

    describe "firm_kind_justification" do
      it { expect(founder_firm).to have_db_column(:firm_kind_justification).of_type(:text) }
    end

    describe "long_description" do
      it { expect(founder_firm).to have_db_column(:long_description).of_type(:text) }

      it "is max 1024 chars" do
        expect(founder_firm)
          .to(
            validate_length_of(:long_description)
              .is_at_most(1024)
          )
      end
    end

    describe "review_state" do
      it { expect(founder_firm).to have_db_column(:review_state).of_type(:string) }
    end

    describe "target_problem" do
      it { expect(founder_firm).to have_db_column(:target_problem).of_type(:text) }

      it "is max 256 chars" do
        expect(founder_firm)
          .to(
            validate_length_of(:target_problem)
              .is_at_most(256)
          )
      end
    end

    describe "short_description" do
      it { expect(founder_firm).to have_db_column(:short_description).of_type(:text) }

      it "is max 128 chars" do
        expect(founder_firm)
          .to(
            validate_length_of(:short_description)
              .is_at_most(128)
          )
      end
    end

    describe "site_url" do
      it { expect(founder_firm).to have_db_column(:site_url).of_type(:text) }
    end

    describe "slug" do
      it { expect(founder_firm).to have_db_column(:slug).of_type(:text) }
    end

    describe "target_customer" do
      it { expect(founder_firm).to have_db_column(:target_customer).of_type(:string) }
    end

    describe "target_industries" do
      it { expect(founder_firm).to have_db_column(:target_industries).of_type(:string) }
    end

    describe "target_locations" do
      it { expect(founder_firm).to have_db_column(:target_locations).of_type(:string) }
    end
  end
end
