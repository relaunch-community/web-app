class UserProfile::ProfessionalsController < ApplicationController
  include ProfileCreatable
  include Pundit::Authorization

  before_action :set_user_profile_professional

  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_access

  # GET /user_profile/professionals/1 or /user_profile/professionals/1.json
  def show
    @available_profile_kinds = creatable_profile_kinds
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile_professional
    @user_profile_professional = policy_scope(UserProfile::Professional).friendly.find(params[:id])
    authorize @user_profile_professional
  end

  # Only allow a list of trusted parameters through.
  def user_profile_professional_params
    params.fetch(:user_profile_professional, {})
  end
end
