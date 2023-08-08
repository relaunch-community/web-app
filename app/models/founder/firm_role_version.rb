# == Schema Information
#
# Table name: founder_firm_role_versions
#
#  id         :bigint           not null, primary key
#  event      :string           not null
#  item_type  :string           not null
#  object     :json
#  whodunnit  :string
#  created_at :datetime
#  item_id    :uuid             not null
#
# Indexes
#
#  index_founder_firm_role_versions_on_item_type_and_item_id  (item_type,item_id)
#
class Founder::FirmRoleVersion < PaperTrail::Version
  self.table_name = :founder_firm_role_versions
end
