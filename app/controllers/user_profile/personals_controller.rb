class UserProfile::PersonalsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :disallow_overwrite_current_profile, only: [:new, :create]
  before_action :set_user_profile_personal, only: %i[show edit update]

  after_action :verify_authorized

  # GET /user_profile/personals/1 or /user_profile/personals/1.json
  def show
  end

  def new
    @user_profile_personal = current_user.build_personal_profile
    authorize @user_profile_personal
  end

  # GET /user_profile/personals/1/edit
  def edit
  end

  def create
    @user_profile_personal = current_user
                             .build_personal_profile(user_profile_personal_params)
    authorize @user_profile_personal

    respond_to do |format|
      if @user_profile_personal.save
        format.html { redirect_to dashboard_path, notice: t(".create_success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_profile/personals/1 or /user_profile/personals/1.json
  def update
    respond_to do |format|
      if @user_profile_personal.update(user_profile_personal_params)
        format.html { redirect_to user_profile_personal_url(@user_profile_personal), notice: t(".update_success") }
        format.json { render :show, status: :ok, location: @user_profile_personal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_profile_personal.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def disallow_overwrite_current_profile
    if current_user.personal_profile.present?
      redirect_back_or_to dashboard_url, allow_other_host: false
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile_personal
    @user_profile_personal = UserProfile::Personal.find(params[:id])
    authorize @user_profile_personal
  end

  # Only allow a list of trusted parameters through.
  def user_profile_personal_params
    params.require(:user_profile_personal)
          .permit(
            :email_address,
            :first_name,
            :freeform_pronouns,
            :headline,
            :last_name,
            :linkedin_url,
            :overview,
            :prepopulated_pronouns,
            :pronoun_visibility,
            :visibility
          )
  end
end
