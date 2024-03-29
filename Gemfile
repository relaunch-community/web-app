# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.5"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails', '~> 2.0', '>= 2.0.29'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "rollbar"

gem "sidekiq", "~> 7.0"

gem "devise", "~> 4.9"

gem "friendly_id", "~> 5.4.0"

gem "countries", "~> 5.5.0"

gem "validate_url", "~> 1.0", ">= 1.0.2"

gem "flipper", "~> 0.28.3"
# https://www.flippercloud.io/docs/adapters/active-record
gem "flipper-active_record", "~> 0.28.3"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 3.2"
  gem "rspec-rails", "~> 6.0"
  gem "shoulda-matchers", "~> 5.0"
  gem "standard", "~> 1.24", require: false
  gem "erb_lint", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "uuid"
end

group :development do
  gem "annotate"
  gem "bundler-licensed", "~> 0.2"
  gem "hotwire-livereload"
  gem "licensed", "~> 3"
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", "~> 0.2", require: false
  gem "webdrivers"
end

gem "aasm", "~> 5.5"
gem "after_commit_everywhere", "~> 1.3"
gem "maintenance_tasks", "~> 2.0"

gem "paper_trail", "~> 15.0"
gem "pundit", "~> 2.3"

gem 'recaptcha', '~> 5.14'

gem "dockerfile-rails", ">= 1.5", :group => :development

gem "fly.io-rails", "~> 0.3.5"
