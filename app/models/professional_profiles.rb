module ProfessionalProfiles
  ALL_KINDS = %w[founder investor vendor]
  def self.table_name_suffix
    "_profile"
  end
end
