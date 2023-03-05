class DashboardController < ApplicationController
  include ProfileCreatable

  def show
    authorize :dashboard, :show?
    @available_profile_kinds = creatable_profile_kinds
  end
end
