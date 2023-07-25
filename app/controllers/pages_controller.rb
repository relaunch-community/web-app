# frozen_string_literal: true

# PagesController handles routes/actions for
# static pages like the #index (home) page.
class PagesController < ApplicationController
  # Override ApplicationController's default
  skip_after_action :verify_authorized

  # Action for the index/home route.
  def index
  end

  def about
  end

  # Action for the privacy policy route.
  def privacy_policy
  end

  # Action for the terms of service route.
  def terms_of_service
  end

  # Action for code of conduct route.
  def code_of_conduct
  end

  # Action for anti-harassment policy route
  def anti_harassment
  end
end
