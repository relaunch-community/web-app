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
class Founder::Firm < ApplicationRecord
  extend FriendlyId
  include ::VisibilityAdjustable
  friendly_id :name, use: :slugged
  has_paper_trail versions: { class_name: "Founder::FirmVersion" }

  belongs_to :headquarters_location,
             class_name: "PhysicalLocation",
             dependent: :destroy

  belongs_to :incorporation_location,
             class_name: "PhysicalLocation",
             optional: true,
             dependent: :destroy

  has_many :founder_firm_roles,
           class_name: "Founder::FirmRole",
           foreign_key: :founder_firm_id,
           inverse_of: :founder_firm,
           dependent: :destroy

  # The creator/manager
  belongs_to :professional_profile,
             class_name: "UserProfile::Professional",
             inverse_of: :managed_founder_firms

  enum firm_kind: {
    "Startup" => 0,
    "Small Business" => 1,
    "Enterprise" => 2,
    "Agency" => 3,
    "Nonprofit" => 4,
    "Other" => 5
  }

  scope :managed_by, ->(professional_profile_id) {
    unscoped
      .where(professional_profile_id: professional_profile_id)
  }

  scope :founded_by, ->(professional_profile_id) {
    unscoped
      .left_outer_joins(:founder_firm_roles)
      .where(founder_firm_roles: { professional_profile_id: professional_profile_id })
  }

  with_options presence: true do
    validates :name
    validates :firm_kind
    validates :short_description
    validates :target_problem
  end

  validates :name, length: { maximum: 256 }
  validates :short_description, length: { maximum: 128 }
  validates :long_description, length: { maximum: 1024 }
  validates :firm_kind_justification, length: { maximum: 1024 }
  validates :site_url, length: { maximum: 768 }

  validates :target_customer, length: { maximum: 256 }
  validates :target_industries, length: { maximum: 256 }
  validates :target_locations, length: { maximum: 256 }
  validates :target_problem, length: { maximum: 256 }

  validates :name, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :headquarters_location
  accepts_nested_attributes_for :incorporation_location
end
