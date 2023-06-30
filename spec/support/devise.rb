RSpec.configure do |config|
  # https://stackoverflow.com/questions/10121835/how-do-i-simulate-a-login-with-rspec
  # https://stackoverflow.com/questions/27284657/undefined-method-env-for-nilnilclass-in-setup-controller-for-warden-error
  config.include Warden::Test::Helpers, type: :request
end
