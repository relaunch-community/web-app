# Models can be referenced here, if needed, within the to_prepare block
# https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#use-case-1-during-boot-load-reloadable-code
# Not needed now, but, ref: https://www.flippercloud.io/docs/features#enablement-group
#
# Only execute outside of the build environment
if ENV.fetch("APP_BUILD_ENVIRONMENT", nil).blank?
  Rails.application.config.after_initialize do
    Flipper.enable_group(:registration, :admins)

    if Rails.env.production? || Rails.env.development?
      Flipper.enable(:recaptcha_verification)
    end
  end
end
