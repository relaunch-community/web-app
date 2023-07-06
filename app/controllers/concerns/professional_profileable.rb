module ProfessionalProfileable
  private

  def creatable_profile_kinds
    # Any user can create any kind of profile, for now.
    # Policies will dictate whether or not a User who has both of an Investor profile and a Founder profile
    # can access other types of gated resources (e.g. founder-only resources).
    ProfessionalProfiles::ALL_KINDS
  end
end
