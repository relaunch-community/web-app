module UserProfile
  ALL_PROFILE_KINDS = %w[professional personal]
  def self.table_name_suffix
    "_user_profiles"
  end
end
