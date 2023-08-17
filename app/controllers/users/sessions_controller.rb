# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # Override ApplicationController's default
  skip_after_action :verify_authorized

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def create
    success = verify_recaptcha(action: "registration",
                               minimum_score: 0.5,
                               secret_key: ENV["RECAPTCHA_SECRET_KEY_V3"])
    checkbox_success = success ? nil : verify_recaptcha # don't allow it to be undefined with the `unless` example

    if success || checkbox_success
      super
    else
      self.resource = resource_class.new(sign_in_params)

      (@show_checkbox_recaptcha = true) unless success
      flash.now[:notice] = I18n.t("recaptcha.verification_request")

      clean_up_passwords resource
      set_minimum_password_length
      render "new"
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
