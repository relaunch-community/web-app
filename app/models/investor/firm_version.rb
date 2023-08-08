# == Schema Information
#
# Table name: investor_firm_versions
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
#  index_investor_firm_versions_on_item_type_and_item_id  (item_type,item_id)
#
class Investor::FirmVersion < PaperTrail::Version
  self.table_name = :investor_firm_versions
end
