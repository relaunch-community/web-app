# Models can be referenced here, if needed, within the to_prepare block
# https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#use-case-1-during-boot-load-reloadable-code
# Not needed now, but, ref: https://www.flippercloud.io/docs/features#enablement-group
Rails.application.config.to_prepare do
  Flipper.enable_group(:registration, :admins)
end
