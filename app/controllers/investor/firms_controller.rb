class Investor::FirmsController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!

  before_action :set_investor_firm, only: %i[edit update destroy]

  after_action :verify_authorized

  # GET /investor/firms or /investor/firms.json
  def index
    @investor_firms = Investor::Firm.all
    authorize @investor_firms
  end

  # GET /investor/firms/1 or /investor/firms/1.json
  def show
    @investor_firm = Investor::Firm.friendly
                                   .includes(investor_firm_roles: { professional_profile: { user: :personal_profile } })
                                   .find(params[:id])
    @investor_firm_roles = @investor_firm.investor_firm_roles
    authorize @investor_firm_roles
  end

  # GET /investor/firms/new
  def new
    @investor_firm = Investor::Firm.new(investor_firm_params)
    authorize @investor_firm
  end

  # GET /investor/firms/1/edit
  def edit
  end

  # POST /investor/firms or /investor/firms.json
  def create
    @investor_firm = Investor::Firm.new(investor_firm_params)
    authorize @investor_firm

    respond_to do |format|
      if @investor_firm.save
        format.html do
          if params[:previous_referer]&.match?(new_investor_firm_role_url)
            redirect_to new_investor_firm_role_url({
              investor_firm_role: { investor_firm_id: @investor_firm.id }
            }),
                        notice: t(".create_success")
          else
            redirect_to investor_firm_url(@investor_firm), notice: t(".create_success")
          end
        end
        format.json { render :show, status: :created, location: @investor_firm }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investor_firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investor/firms/1 or /investor/firms/1.json
  def update
    respond_to do |format|
      if @investor_firm.update(investor_firm_params)
        format.html { redirect_to investor_firm_url(@investor_firm), notice: t(".update_success") }
        format.json { render :show, status: :ok, location: @investor_firm }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investor_firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investor/firms/1 or /investor/firms/1.json
  def destroy
    @investor_firm.destroy

    respond_to do |format|
      format.html { redirect_to investor_firms_url, notice: t(".destroy_success") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_investor_firm
    @investor_firm = Investor::Firm.friendly.find(params[:id])
    authorize @investor_firm
  end

  # Only allow a list of trusted parameters through.
  def investor_firm_params
    params.fetch(:investor_firm, {})
          .permit(:name,
                  :thesis,
                  :overview,
                  :site_url,
                  :physical_location_id,
                  physical_location_attributes: [:city, :state_subdivision, :country])
  end
end
