# == Schema Information
#
# Table name: founder_firm_roles
#
#  id                              :uuid             not null, primary key
#  departed_on                     :datetime
#  joined_at                       :datetime
#  ownership_confirmation_checkbox :boolean          default(FALSE), not null
#  ownership_percentage            :decimal(, )      not null
#  title                           :string           not null
#  visibility                      :integer          not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  founder_firm_id                 :uuid             not null
#  professional_profile_id         :uuid             not null
#
# Indexes
#
#  index_founder_firm_roles_on_founder_firm_id          (founder_firm_id)
#  index_founder_firm_roles_on_professional_profile_id  (professional_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (founder_firm_id => founder_firms.id)
#  fk_rails_...  (professional_profile_id => professionals_user_profiles.id)
#
require "rails_helper"

RSpec.describe Founder::FirmRole do
  describe "associations" do
    subject(:founder_firm_role) { build(:founder_firm_role, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    it { is_expected.to belong_to(:founder_firm) }
    it { is_expected.to belong_to(:professional_profile) }
    it { is_expected.to have_many(:versions).class_name("Founder::FirmRoleVersion") }
  end

  describe "attributes" do
    subject(:founder_firm_role) { build(:founder_firm_role, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    describe "title" do
      it { is_expected.to validate_presence_of(:title) }

      it "is a string" do
        expect(founder_firm_role.title).to be_a(String)
      end
    end

    describe "joined_at" do
      it { expect(founder_firm_role).to have_db_column(:joined_at).of_type(:datetime) }
    end

    describe "departed_on" do
      it { expect(founder_firm_role).to have_db_column(:departed_on).of_type(:datetime) }
    end

    describe "ownership_percentage" do
      it { is_expected.to validate_presence_of(:ownership_percentage) }
      it { expect(founder_firm_role).to have_db_column(:ownership_percentage).of_type(:decimal) }
    end

    describe "ownership_confirmation_checkbox" do
      it { expect(founder_firm_role).to have_db_column(:ownership_confirmation_checkbox).of_type(:boolean) }

      it "is a required field" do
        expect(founder_firm_role).to validate_inclusion_of(:ownership_confirmation_checkbox)
          .in_array([true])
          .with_message(I18n.t("activerecord.models.founder.firm_role.must_confirm_ownership"))
      end
    end

    describe "visibility" do
      it { is_expected.to validate_presence_of(:visibility) }

      it { expect(founder_firm_role).to have_db_column(:visibility).of_type(:integer) }

      it do
        expect(founder_firm_role)
          .to(
            define_enum_for(:visibility)
              .with_values(["Public", "Internal (members-only)", "Private (admins-only)"])
          )
      end
    end
  end

  describe "versioning" do
    subject(:founder_firm_role) { create(:founder_firm_role, professional_profile: user.professional_profile) }

    let(:user) { create(:user) }

    before do
      founder_firm_role.title = "#{Faker::Job.title} #{SecureRandom.hex(32)}"
    end

    it "saves a new version" do
      expect { founder_firm_role.save }.to change(founder_firm_role.versions, :count).by(1)
    end
  end
end
