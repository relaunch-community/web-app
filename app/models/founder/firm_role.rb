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
#  professional_profile_id         :bigint           not null
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
class Founder::FirmRole < ApplicationRecord
  include ::VisibilityAdjustable

  has_paper_trail versions: { class_name: "Founder::FirmRoleVersion" }

  belongs_to :founder_firm,
             class_name: "Founder::Firm",
             inverse_of: :founder_firm_roles

  belongs_to :professional_profile,
             class_name: "UserProfile::Professional",
             inverse_of: :founder_firm_roles

  with_options presence: true do
    validates :title
    validates :ownership_percentage
  end

  validates :ownership_percentage, numericality: {
    less_than_or_equal_to: 100,
    greater_than_or_equal_to: 0
  }

  validates :ownership_confirmation_checkbox, inclusion: {
    in: [true],
    message: I18n.t("activerecord.models.founder.firm_role.must_confirm_ownership")
  }

  accepts_nested_attributes_for :founder_firm
end
