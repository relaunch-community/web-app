module Profile
  ALL_PROFILE_KINDS = %w[founder investor vendor]
  def self.table_name_suffix
    "_profile"
  end
end
