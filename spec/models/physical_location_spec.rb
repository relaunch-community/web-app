# == Schema Information
#
# Table name: physical_locations
#
#  id                :bigint           not null, primary key
#  city              :text
#  country           :text
#  state_subdivision :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  hash_id           :uuid
#
# Indexes
#
#  index_physical_locations_on_hash_id  (hash_id) UNIQUE
#
require "rails_helper"

RSpec.describe PhysicalLocation do
  describe "attributes" do
    subject(:physical_location) { create(:physical_location_complete) }

    describe "hash_id" do
      it { is_expected.to validate_presence_of(self.class.description) }

      it "is a uuid" do
        expect(physical_location.hash_id).to be_a(String)
      end

      it { is_expected.to validate_uniqueness_of(:hash_id).case_insensitive }
    end

    describe "country" do
      it { expect(physical_location).to have_db_column(:country).of_type(:text) }

      it "is a required field" do
        expect(physical_location).to validate_presence_of(:country)
      end
    end

    describe "state_subdivision" do
      it { expect(physical_location).to have_db_column(:state_subdivision).of_type(:text) }
    end

    describe "city" do
      it { expect(physical_location).to have_db_column(:city).of_type(:text) }

      it "is a required field" do
        expect(physical_location).to validate_presence_of(:city)
      end
    end
  end
end
