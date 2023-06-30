# == Schema Information
#
# Table name: professionals_user_profiles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hash_id    :uuid
#  user_id    :uuid             not null
#
# Indexes
#
#  index_professionals_user_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserProfile::Professional < ApplicationRecord
  include FriendlyId

  # https://norman.github.io/friendly_id/file.Guide.html
  # use column as-is
  friendly_id :hash_id

  belongs_to :user

  validates :hash_id, presence: true
  validates :hash_id, uniqueness: { case_sensitive: false }

  before_validation :set_hash_id, on: :create

  def any_profiles?
    false # check if any founder, investor, vendor profiles exist
  end

  def has_no_profiles?
    !any_profiles?
  end

  private

  def set_hash_id
    self.hash_id ||= Digest::UUID.uuid_v4
  end
end
