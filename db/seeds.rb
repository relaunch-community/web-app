# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development? || Rails.env.test?
  require "factory_bot_rails"
  # rubocop:disable Style/MixinUsage
  include FactoryBot::Syntax::Methods
  # rubocop:enable Style/MixinUsage

  def seed_users!(destroy_current = false)
    User.delete_all if destroy_current

    user_emails = %w[admin@relaunchcommunity.org founder@examplestartup.com vendor@exampleagency.com]

    user_emails.map do |email|
      user = create(:user, email: email, encrypted_password: Devise::Encryptor.digest(User, "passwordpassword"))
      create(:user_profile_personal, user: user)
      # Professional profile created in callback via User model
    end
  end

  seed_users!(true)
end
