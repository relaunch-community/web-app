# == Schema Information
#
# Table name: personals_user_profiles
#
#  id                     :bigint           not null, primary key
#  email_address          :string(319)      not null
#  first_name             :text
#  freeform_pronouns      :text
#  headline               :string(128)
#  last_name              :text
#  linkedin_url           :text
#  original_email_address :string           not null
#  original_linkedin_url  :text
#  overview               :string(1024)
#  prepopulated_pronouns  :text             not null
#  pronoun_visibility     :boolean
#  visibility             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  hash_id                :uuid
#  user_id                :uuid             not null
#
# Indexes
#
#  index_personals_user_profiles_on_email_address       (email_address) UNIQUE
#  index_personals_user_profiles_on_hash_id             (hash_id) UNIQUE
#  index_personals_user_profiles_on_pronoun_visibility  (pronoun_visibility)
#  index_personals_user_profiles_on_user_id             (user_id) UNIQUE
#  index_personals_user_profiles_on_visibility          (visibility)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe UserProfile::Personal do
  describe "associations" do
    subject!(:personal_profile) { user.build_personal_profile }

    let(:user) { create(:user) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:versions).class_name("UserProfile::PersonalVersion") }
  end

  describe "attributes" do
    # Required for validations; otherwise, rspec will fill-in the gaps
    subject!(:personal_profile) { build(:user_profile_personal) }

    describe "first_name" do
      it "is encrypted upon save" do
        expect { personal_profile.save! }
          .to(
            change { personal_profile.encrypted_attribute?(:first_name) }
              .from(false)
              .to(true)
          )
      end

      it "is a required field" do
        expect(personal_profile).to validate_presence_of(:first_name)
      end
    end

    describe "last_name" do
      it "is encrypted upon save" do
        expect { personal_profile.save! }
          .to(
            change { personal_profile.encrypted_attribute?(:last_name) }
              .from(false)
              .to(true)
          )
      end

      it "is a required field" do
        expect(personal_profile).to validate_presence_of(:last_name)
      end
    end

    describe "email_address" do
      describe "validations" do
        # https://sendgrid.com/blog/email-marketing-length-best-practices/
        it "is between 4 and 319 desired characters long" do
          expect(personal_profile).to(
            validate_length_of(:email_address)
              .is_at_most(319)
          )
        end

        describe "uniqueness" do
          let!(:personal_profile_dup) { personal_profile.deep_dup }

          before { personal_profile.save! }

          it "is unique" do
            expect(personal_profile).to validate_uniqueness_of(:email_address).case_insensitive
          end

          it "and duplicate items aren't allowed" do
            expect(personal_profile_dup.save).to be false
          end
        end
      end

      it "is encrypted upon save" do
        expect { personal_profile.save! }
          .to(
            change { personal_profile.encrypted_attribute?(:email_address) }
              .from(false)
              .to(true)
          )
      end
    end

    describe "linkedin_url" do
      describe "validations" do
        it "is a required field" do
          expect(personal_profile).to validate_presence_of(:linkedin_url)
        end

        it "is between 17 (linkedin.com/in/) and 1024 desired characters long" do
          expect(personal_profile).to(
            validate_length_of(:linkedin_url)
              .is_at_least(17)
              .is_at_most(1024)
          )
        end

        describe "uniqueness" do
          let!(:personal_profile_dup) { personal_profile.deep_dup }

          before { personal_profile.save! }

          it "is unique" do
            expect(personal_profile).to validate_uniqueness_of(:linkedin_url).case_insensitive
          end

          it "and duplicate items aren't allowed" do
            expect(personal_profile_dup.save).to be false
          end
        end
      end

      it "is encrypted upon save" do
        expect { personal_profile.save! }
          .to(
            change { personal_profile.encrypted_attribute?(:linkedin_url) }
              .from(false)
              .to(true)
          )
      end
    end

    describe "headline" do
      it "is max 128 chars" do
        expect(personal_profile)
          .to(
            validate_length_of(:headline)
              .is_at_most(128)
          )
      end
    end

    describe "overview" do
      it "is max 1024 chars" do
        expect(personal_profile)
          .to(
            validate_length_of(:overview)
              .is_at_most(1024)
          )
      end

      it "is encrypted upon save" do
        expect { personal_profile.save! }
          .to(
            change { personal_profile.encrypted_attribute?(:overview) }
              .from(false)
              .to(true)
          )
      end
    end

    describe "visibility" do
      it { expect(personal_profile).to have_db_column(:visibility).of_type(:integer) }

      it do
        expect(personal_profile)
          .to(
            define_enum_for(:visibility)
              .with_values(personal_profile.class.visibilities.keys)
          )
      end

      it "is a required field" do
        expect(personal_profile).to validate_presence_of(:visibility)
      end
    end

    describe "pronoun_visibility" do
      it { expect(personal_profile).to have_db_column(:pronoun_visibility).of_type(:boolean) }

      # Keep this test, to exclude nils
      it "is a required field" do
        expect(personal_profile).to validate_inclusion_of(:pronoun_visibility).in_array([true, false])
      end
    end

    describe "prepopulated_pronouns" do
      it "is encrypted upon save" do
        expect { personal_profile.save! }
          .to(
            change { personal_profile.encrypted_attribute?(:prepopulated_pronouns) }
              .from(false)
              .to(true)
          )
      end

      it "is a required field" do
        expect(personal_profile).to validate_presence_of(:prepopulated_pronouns)
      end
    end

    describe "freeform_pronouns" do
      it "is max 32 chars" do
        expect(personal_profile)
          .to(
            validate_length_of(:freeform_pronouns).is_at_most(32)
          )
      end

      it "is encrypted upon save" do
        expect { personal_profile.save! }
          .to(
            change { personal_profile.encrypted_attribute?(:freeform_pronouns) }
              .from(false)
              .to(true)
          )
      end
    end
  end

  describe "versioning" do
    subject!(:personal_profile) { create(:user_profile_personal) }

    it "saves a new version" do
      # rubocop:disable Rails/SkipsModelValidations
      expect { personal_profile.touch }.to change(personal_profile.versions, :count).by(1)
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
