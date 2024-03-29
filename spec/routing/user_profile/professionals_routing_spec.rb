require "rails_helper"

RSpec.describe UserProfile::ProfessionalsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/profile/professional").to route_to("user_profile/professionals#index")
    end

    it "routes to #show" do
      expect(get: "/profile/professional/1").to route_to("user_profile/professionals#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/profile/professional/1/edit").to route_to("user_profile/professionals#edit", id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/profile/professional/1").to route_to("user_profile/professionals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/profile/professional/1").to route_to("user_profile/professionals#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/profile/professional/1").to route_to("user_profile/professionals#destroy", id: "1")
    end
  end
end
