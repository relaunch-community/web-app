class ApplicationController < ActionController::Base
  include Pundit::Authorization
  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_access

  private

  # For now, redirect all users to dashboard after sign in and sign up
  def after_sign_in_path_for(resource_or_scope)
    dashboard_path
  end

  def after_signup_path_for(resource_or_scope)
    dashboard_path
  end

  def unauthorized_access
    flash[:alert] = I18n.t("unauthorized_access")
    redirect_back(fallback_location: root_path)
  end
end
