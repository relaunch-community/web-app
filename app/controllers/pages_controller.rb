# frozen_string_literal: true

# PagesController handles routes/actions for
# static pages like the #index (home) page.
class PagesController < ApplicationController

  # Action for the index/home route.
  def index; end
  # Action for the privacy policy route.
  def privacy_policy; end
  # Action for the terms of service route.
  def terms_of_service; end
end
