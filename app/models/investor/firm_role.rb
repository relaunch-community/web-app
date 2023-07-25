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
#  physical_location_id         :bigint
#  professional_profile_id      :bigint           not null
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
#  fk_rails_...  (professional_profile_id => professionals_user_profiles.id)
#
class Investor::FirmRole < ApplicationRecord
  belongs_to :physical_location, dependent: :destroy

  belongs_to :investor_firm,
             class_name: "Investor::Firm",
             inverse_of: :investor_firm_roles

  belongs_to :professional_profile,
             class_name: "UserProfile::Professional",
             inverse_of: :investor_firm_roles

  with_options presence: true do
    validates :title
  end

  accepts_nested_attributes_for :investor_firm
  accepts_nested_attributes_for :physical_location
end
