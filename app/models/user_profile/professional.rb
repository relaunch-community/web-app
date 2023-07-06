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
  include ::HashFriendable

  belongs_to :user

  def any_profiles?
    false # check if any founder, investor, vendor profiles exist
  end

  def has_no_profiles?
    !any_profiles?
  end
end
