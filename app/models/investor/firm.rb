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
class Investor::Firm < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :physical_location,
             dependent: :destroy

  has_many :investor_firm_roles,
           class_name: "Investor::FirmRole",
           foreign_key: :investor_firm_id,
           inverse_of: :investor_firm,
           dependent: :destroy

  # The creator/manager
  belongs_to :professional_profile,
             class_name: "UserProfile::Professional",
             inverse_of: :managed_investor_firms

  scope :managed_by, ->(professional_profile_id) {
    unscoped
      .where(professional_profile_id: professional_profile_id)
  }

  scope :employer_of, ->(professional_profile_id) {
    unscoped
      .left_outer_joins(:investor_firm_roles)
      .where(investor_firm_roles: { professional_profile_id: professional_profile_id })
  }

  with_options presence: true do
    validates :name
    validates :site_url
  end

  validates :site_url, url: { public_suffix: true }

  validates :name, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :physical_location
end
