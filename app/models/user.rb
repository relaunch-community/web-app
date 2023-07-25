# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  roles_mask             :integer
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_roles_mask            (roles_mask)
#
class User < ApplicationRecord
  include Flipper::Identifier

  # Include default devise modules. Others available are:
  # :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable
  # TODO: configure omniauth
  # , :omniauthable

  encrypts :email, deterministic: true, ignore_case: true

  has_one :professional_profile, class_name: "UserProfile::Professional", dependent: :destroy
  has_one :personal_profile, class_name: "UserProfile::Personal", dependent: :destroy

  scope :with_role, ->(role) { where("roles_mask & #{2**ROLES.index(role.to_s)} > 0 ") }
  scope :admins, -> { with_role(:admin) }

  after_create :create_professional_profile!

  ROLES = %w[superadmin admin]

  def has_professional_profiles?
    professional_profile.any_profiles?
  end

  def has_no_professional_profiles?
    !has_professional_profiles?
  end

  # Placeholder
  def admin?
    (roles & %w[admin superadmin]).any?
  end

  def roles=(roles)
    self.roles_mask = (roles.map(&:to_s) & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role_symbols
    roles.map(&:to_sym)
  end
end
