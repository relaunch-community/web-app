class Investor::FirmRolesController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!

  before_action :set_investor_firm, only: %i[index edit update destroy]
  before_action :set_investor_firm_role, only: %i[edit update destroy]

  after_action :verify_authorized

  # GET /investor/firm_roles or /investor/firm_roles.json
  def index
    @investor_firm_roles = @investor_firm.investor_firm_roles.load
    authorize @investor_firm_roles
  end

  # GET /investor/firm_roles/new
  def new
    @investor_firms = Investor::Firm.all.order(name: :asc)
    @investor_firm_role = current_user
                          .professional_profile
                          .investor_firm_roles
                          .build(investor_firm_role_params)
    authorize @investor_firm_role
  end

  # GET /investor/firm_roles/1/edit
  def edit
  end

  # POST /investor/firm_roles or /investor/firm_roles.json
  def create
    @investor_firm_role = current_user
                          .professional_profile
                          .investor_firm_roles
                          .build(investor_firm_role_params)
    authorize @investor_firm_role

    respond_to do |format|
      if @investor_firm_role.save
        format.html { redirect_to investor_firm_url(@investor_firm_role.investor_firm_id), notice: t(".create_success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investor/firm_roles/1 or /investor/firm_roles/1.json
  def update
    respond_to do |format|
      if @investor_firm_role.update(investor_firm_role_params)
        format.html { redirect_to investor_firm_firm_role_url(@investor_firm, @investor_firm_role), notice: t(".update_success") }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investor_firm_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investor/firm_roles/1 or /investor/firm_roles/1.json
  def destroy
    @investor_firm_role.destroy

    respond_to do |format|
      format.html { redirect_to investor_firm_roles_url, notice: t(".destroy.destroy_success") }
      format.json { head :no_content }
    end
  end

  private

  def set_investor_firm
    @investor_firm = Investor::Firm.friendly.find(params[:firm_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_investor_firm_role
    @investor_firm_role = Investor::FirmRole.find(params[:id])
    authorize @investor_firm_role
  end

  # Only allow a list of trusted parameters through.
  def investor_firm_role_params
    params.fetch(:investor_firm_role, {})
          .permit(:title,
                  :why_here,
                  :investment_target_stage,
                  :investment_target_customer,
                  :investment_target_industries,
                  :investor_firm_id,
                  :location_id,
                  :overview,
                  physical_location_attributes: [:city, :state_subdivision, :country])
  end
end
