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
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable
  # TODO: configure omniauth
  # , :omniauthable

  encrypts :email, deterministic: true, ignore_case: true

  has_one :professional_profile, class_name: "UserProfile::Professional", dependent: :destroy

  after_create :create_professional_profile!

  def has_professional_profiles?
    professional_profile.any_profiles?
  end

  def has_no_professional_profiles?
    !has_professional_profiles?
  end

  # Placeholder
  def admin?
    false
  end
end
