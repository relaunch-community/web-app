class DashboardController < ApplicationController
  before_action :ensure_professional_profile_populated

  def show
    authorize :dashboard, :show?
  end

  private

  def ensure_professional_profile_populated
    if current_user.has_no_professional_profiles?
      redirect_to user_profile_professional_url(current_user.professional_profile), notice: t(".missing_professional_profiles_notice")
    end
  end
end
