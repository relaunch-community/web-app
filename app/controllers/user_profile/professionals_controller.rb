class UserProfile::ProfessionalsController < ApplicationController
  include ProfessionalProfileable
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_user_profile_professional, only: [:show, :edit, :update]

  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_access

  def index
    @user_profile_professionals = policy_scope(UserProfile::Professional).all
    authorize @user_profile_professionals
  end

  # GET /user_profile/professionals/1 or /user_profile/professionals/1.json
  def show
    @available_profile_kinds = creatable_profile_kinds
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user_profile_professional.update(user_profile_professional_params)
        format.html { redirect_to user_profile_professional_url(@user_profile_professional), notice: t(".update_success") }
        format.json { render :show, status: :ok, location: @user_profile_professional }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_profile_professional.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile_professional
    @user_profile_professional = policy_scope(UserProfile::Professional).find(params[:id])
    authorize @user_profile_professional
  end

  # Only allow a list of trusted parameters through.
  def user_profile_professional_params
    params.fetch(:user_profile_professional, {})
  end
end
