# == Schema Information
#
# Table name: personals_user_profiles
#
#  id                    :bigint           not null, primary key
#  email_address         :string(319)      not null
#  first_name            :text
#  freeform_pronouns     :text
#  headline              :string(128)
#  last_name             :text
#  linkedin_url          :text
#  overview              :string(1024)
#  prepopulated_pronouns :text             not null
#  pronoun_visibility    :boolean
#  visibility            :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  hash_id               :uuid
#  user_id               :uuid             not null
#
# Indexes
#
#  index_personals_user_profiles_on_pronoun_visibility  (pronoun_visibility)
#  index_personals_user_profiles_on_user_id             (user_id)
#  index_personals_user_profiles_on_visibility          (visibility)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserProfile::Personal < ApplicationRecord
  include FriendlyId
  include ::HashFriendable

  belongs_to :user

  #  - ref:
  #   https://www.gsrc.princeton.edu/creating-inclusive-forms
  #   https://www.keshetonline.org/resources/forms/
  #   https://uwm.edu/lgbtrc/support/gender-pronouns/
  attribute :prepopulated_pronouns, :integer

  enum prepopulated_pronouns: {
    "She/Her/Hers" => 0,
    "He/Him/His" => 1,
    "Ze/Hir/Hirs" => 2,
    "They/Them/Theirs" => 3,
    "It/It/Its" => 4,
    "Just my name, please! (no pronoun)" => 5,
    "Not listed" => 6
  }

  enum visibility: {
    "Public" => 0,
    "Internal (members-only)" => 1,
    "Private (admins-only)" => 2
  }

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :linkedin_url
    validates :prepopulated_pronouns
    validates :visibility
  end

  validates :pronoun_visibility, inclusion: { in: [true, false] }

  validates :email_address,
            length: { in: 4..319 },
            uniqueness: true,
            unless: ->(profile) { profile.email_address.blank? }

  validates :linkedin_url,
            length: { in: 17..1024 },
            uniqueness: true,
            unless: ->(profile) { profile.linkedin_url.blank? }

  validates :headline, length: { maximum: 128 }
  validates :overview, length: { maximum: 1024 }

  validates :freeform_pronouns, length: { maximum: 32 }
  validates :prepopulated_pronouns,
            inclusion: prepopulated_pronouns.keys,
            unless: ->(profile) { profile.prepopulated_pronouns.blank? }

  encrypts :first_name, deterministic: false
  encrypts :last_name, deterministic: false
  encrypts :overview, deterministic: false
  encrypts :freeform_pronouns, deterministic: false
  encrypts :prepopulated_pronouns, deterministic: false

  encrypts :email_address, deterministic: true, ignore_case: true
  encrypts :linkedin_url, deterministic: true, ignore_case: true
end
