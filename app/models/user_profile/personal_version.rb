# == Schema Information
#
# Table name: user_profile_personal_versions
#
#  id         :bigint           not null, primary key
#  event      :string           not null
#  item_type  :string           not null
#  object     :json
#  whodunnit  :string
#  created_at :datetime
#  item_id    :bigint           not null
#
# Indexes
#
#  index_user_profile_personal_versions_on_item_type_and_item_id  (item_type,item_id)
#
class UserProfile::PersonalVersion < PaperTrail::Version
  self.table_name = :user_profile_personal_versions
end