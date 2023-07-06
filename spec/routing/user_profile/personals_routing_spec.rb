require "rails_helper"

RSpec.describe UserProfile::PersonalsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/profile/personal").to route_to("user_profile/personals#index")
    end

    it "routes to #new" do
      expect(get: "/profile/personal/new").to route_to("user_profile/personals#new")
    end

    it "routes to #show" do
      expect(get: "/profile/personal/1").to route_to("user_profile/personals#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/profile/personal/1/edit").to route_to("user_profile/personals#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/profile/personal").to route_to("user_profile/personals#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/profile/personal/1").to route_to("user_profile/personals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/profile/personal/1").to route_to("user_profile/personals#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/profile/personal/1").to route_to("user_profile/personals#destroy", id: "1")
    end
  end
end
