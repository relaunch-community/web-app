class PhysicalLocationsController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_physical_location, only: %i[show edit update]

  after_action :verify_authorized

  # GET /physical_locations/1 or /physical_locations/1.json
  def show
  end

  # GET /physical_locations/new
  def new
    @physical_location = PhysicalLocation.new(physical_location_params)
    authorize @physical_location
  end

  # GET /physical_locations/1/edit
  def edit
  end

  # POST /physical_locations or /physical_locations.json
  def create
    @physical_location = PhysicalLocation.new(physical_location_params)
    authorize @physical_location

    respond_to do |format|
      if @physical_location.save
        format.html { redirect_to physical_location_url(@physical_location), notice: t(".create_success") }
        format.json { render :show, status: :created, location: @physical_location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @physical_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /physical_locations/1 or /physical_locations/1.json
  def update
    respond_to do |format|
      if @physical_location.update(physical_location_params)
        format.html { redirect_to physical_location_url(@physical_location), notice: t(".update_success") }
        format.json { render :show, status: :ok, location: @physical_location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @physical_location.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_physical_location
    @physical_location = policy_scope(PhysicalLocation).friendly.find(params[:id])
    authorize @physical_location
  end

  # Only allow a list of trusted parameters through.
  def physical_location_params
    params.fetch(:physical_location, {}).permit(:city, :state_subdivision, :country)
  end
end
