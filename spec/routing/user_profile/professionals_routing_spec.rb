require "rails_helper"

RSpec.describe UserProfile::ProfessionalsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_profile/professionals").to route_to("user_profile/professionals#index")
    end

    it "routes to #new" do
      expect(get: "/user_profile/professionals/new").to route_to("user_profile/professionals#new")
    end

    it "routes to #show" do
      expect(get: "/user_profile/professionals/1").to route_to("user_profile/professionals#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_profile/professionals/1/edit").to route_to("user_profile/professionals#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/user_profile/professionals").to route_to("user_profile/professionals#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_profile/professionals/1").to route_to("user_profile/professionals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_profile/professionals/1").to route_to("user_profile/professionals#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_profile/professionals/1").to route_to("user_profile/professionals#destroy", id: "1")
    end
  end
end
