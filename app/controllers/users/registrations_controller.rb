# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Pundit::Authorization
  before_action :ensure_enabled, only: [:create]
  # Override ApplicationController's default
  skip_after_action :verify_authorized, only: [:new, :create]

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    if Flipper.enabled?(:recaptcha_verification)
      success = verify_recaptcha(action: "registration",
                                 minimum_score: 0.5,
                                 secret_key: ENV["RECAPTCHA_SECRET_KEY_V3"])
      checkbox_success = success ? nil : verify_recaptcha(model: resource) # don't allow it to be undefined with the `unless` example

      if success || checkbox_success
        super
      else
        (@show_checkbox_recaptcha = true) unless success
        flash.now[:notice] = I18n.t("recaptcha.verification_request")

        clean_up_passwords resource
        set_minimum_password_length
        render "new"
      end
    else
      # Rather than moving the conditional out, just nesting for now
      super
    end
  end

  def ensure_enabled
    raise ActionController::RoutingError.new("Sorry, we haven't enabled that yet!") unless Flipper.enabled?(:registration, current_user)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
