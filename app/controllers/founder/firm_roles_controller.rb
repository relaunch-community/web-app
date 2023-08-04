class Founder::FirmRolesController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!

  before_action :set_founder_firms, only: %i[new create]
  before_action :set_founder_firm, only: %i[index edit update destroy]
  before_action :set_founder_firm_role, only: %i[show edit update destroy]

  after_action :verify_authorized

  # GET /founder/firm_roles or /founder/firm_roles.json
  def index
    @founder_firm_roles = Founder::FirmRole.all
  end

  # GET /founder/firm_roles/1 or /founder/firm_roles/1.json
  def show
  end

  # GET /founder/firm_roles/new
  def new
    @founder_firm_role = current_user
                         .professional_profile
                         .founder_firm_roles
                         .build(founder_firm_role_params)
    authorize @founder_firm_role
  end

  # GET /founder/firm_roles/1/edit
  def edit
  end

  # POST /founder/firm_roles or /founder/firm_roles.json
  def create
    @founder_firm_role = current_user
                         .professional_profile
                         .founder_firm_roles
                         .build(founder_firm_role_params)
    authorize @founder_firm_role

    respond_to do |format|
      if @founder_firm_role.save
        format.html { redirect_to founder_firm_role_url(@founder_firm_role), notice: t(".create_success") }
        format.json { render :show, status: :created, location: @founder_firm_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @founder_firm_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /founder/firm_roles/1 or /founder/firm_roles/1.json
  def update
    respond_to do |format|
      if @founder_firm_role.update(founder_firm_role_params)
        format.html { redirect_to founder_firm_role_url(@founder_firm_role), notice: t(".update_success") }
        format.json { render :show, status: :ok, location: @founder_firm_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @founder_firm_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /founder/firm_roles/1 or /founder/firm_roles/1.json
  def destroy
    @founder_firm_role.destroy

    respond_to do |format|
      format.html { redirect_to founder_firm_roles_url, notice: t(".destroy_success") }
      format.json { head :no_content }
    end
  end

  private

  def set_founder_firms
    @founder_firms = policy_scope(Founder::Firm).all.order(name: :asc)
    authorize @founder_firms
  end

  def set_founder_firm
    @founder_firm = policy_scope(Founder::Firm).friendly.find(params[:firm_id])
    authorize @founder_firm
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_founder_firm_role
    @founder_firm_role = Founder::FirmRole.find(params[:id])
    authorize @founder_firm_role
  end

  # Only allow a list of trusted parameters through.
  def founder_firm_role_params
    params.fetch(:founder_firm_role, {})
          .permit(:title,
                  :ownership_percentage,
                  :ownership_confirmation_checkbox,
                  :visibility,
                  :founder_firm_id,
                  :physical_location_id)
  end
end
