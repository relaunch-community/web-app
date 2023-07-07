class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_personal_profile_exists
  before_action :ensure_professional_profile_populated

  def show
    authorize :dashboard, :show?
  end

  private

  def ensure_personal_profile_exists
    if current_user.personal_profile.blank?
      redirect_to new_user_profile_personal_url,
                  format: request.format
    end
  end

  def ensure_professional_profile_populated
    if current_user.has_no_professional_profiles?
      redirect_to user_profile_professional_url(current_user.professional_profile),
                  format: request.format
    end
  end
end
