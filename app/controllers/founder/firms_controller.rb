class Founder::FirmsController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!

  before_action :set_founder_firm, only: %i[edit update destroy]

  after_action :verify_authorized

  # GET /founder/firms or /founder/firms.json
  def index
    @founder_firms = Founder::Firm.all
    authorize @founder_firms
  end

  # GET /founder/firms/1 or /founder/firms/1.json
  def show
    @founder_firm = Founder::Firm.friendly
                                 .includes(founder_firm_roles: { professional_profile: { user: :personal_profile } })
                                 .find(params[:id])
    @founder_firm_roles = @founder_firm.founder_firm_roles
    authorize @founder_firm
    authorize @founder_firm_roles
  end

  # GET /founder/firms/new
  def new
    @founder_firm = current_user
                    .professional_profile
                    .managed_founder_firms
                    .build(founder_firm_params)
    authorize @founder_firm
  end

  # GET /founder/firms/1/edit
  def edit
  end

  # POST /founder/firms or /founder/firms.json
  def create
    @founder_firm = current_user
                    .professional_profile
                    .managed_founder_firms
                    .build(founder_firm_params)
    @founder_firm.review_state_progression = true

    authorize @founder_firm

    respond_to do |format|
      if @founder_firm.save
        format.html do
          if params[:previous_referer]&.match?(new_founder_firm_role_url) || current_user.professional_profile.founder_firm_roles.empty?
            redirect_to new_founder_firm_role_url({
              founder_firm_role: { founder_firm_id: @founder_firm.id }
            }),
                        notice: t(".create_success_with_redirect")
          else
            redirect_to founder_firm_url(@founder_firm), notice: t(".create_success")
          end
        end
        format.json { render :show, status: :created, location: @founder_firm }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @founder_firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /founder/firms/1 or /founder/firms/1.json
  def update
    respond_to do |format|
      if @founder_firm.update(founder_firm_params)
        format.html { redirect_to founder_firm_url(@founder_firm), notice: t(".update_success") }
        format.json { render :show, status: :ok, location: @founder_firm }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @founder_firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /founder/firms/1 or /founder/firms/1.json
  def destroy
    @founder_firm.destroy

    respond_to do |format|
      format.html { redirect_to founder_firms_url, notice: t(".destroy_success") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_founder_firm
    @founder_firm = Founder::Firm.friendly.find(params[:id])
    authorize @founder_firm
  end

  # Only allow a list of trusted parameters through.
  def founder_firm_params
    params.fetch(:founder_firm, {})
          .permit(:id,
                  :name,
                  :field_visibility,
                  :ended_on,
                  :firm_kind,
                  :firm_kind_justification,
                  :founded_at,
                  :ended_on,
                  :short_description,
                  :long_description,
                  :site_url,
                  :target_customer,
                  :target_problem,
                  :visibility,
                  :headquarters_location_id,
                  :incorporation_location_id,
                  headquarters_location_attributes: [:city, :state_subdivision, :country])
  end
end
