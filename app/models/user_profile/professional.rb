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
class UserProfile::Professional < ApplicationRecord
  has_paper_trail versions: { class_name: "UserProfile::ProfessionalVersion" }

  belongs_to :user

  has_many :investor_firm_roles,
           class_name: "Investor::FirmRole",
           inverse_of: :professional_profile,
           foreign_key: :professional_profile_id,
           dependent: :destroy

  has_many :founder_firm_roles,
           class_name: "Founder::FirmRole",
           inverse_of: :professional_profile,
           foreign_key: :professional_profile_id,
           dependent: :destroy

  has_many :managed_founder_firms,
           class_name: "Founder::Firm",
           inverse_of: :professional_profile,
           foreign_key: :professional_profile_id,
           dependent: :destroy

  has_many :managed_investor_firms,
           class_name: "Investor::Firm",
           inverse_of: :professional_profile,
           foreign_key: :professional_profile_id,
           dependent: :destroy

  def any_founder_profiles?
    managed_founder_firms.any? || founder_firm_roles.any?
  end

  def any_investor_profiles?
    managed_investor_firms.any? || investor_firm_roles.any?
  end

  def any_profiles?
    any_founder_profiles? || any_investor_profiles? # check if any founder, investor, vendor profiles exist
  end

  def has_no_profiles?
    !any_profiles?
  end
end
