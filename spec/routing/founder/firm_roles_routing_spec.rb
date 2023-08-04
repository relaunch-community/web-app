require "rails_helper"

RSpec.describe Founder::FirmRolesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/founder/firm_roles").to route_to("founder/firm_roles#index")
    end

    it "routes to #new" do
      expect(get: "/founder/firm_roles/new").to route_to("founder/firm_roles#new")
    end

    it "routes to #show" do
      expect(get: "/founder/firm_roles/1").to route_to("founder/firm_roles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/founder/firm_roles/1/edit").to route_to("founder/firm_roles#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/founder/firm_roles").to route_to("founder/firm_roles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/founder/firm_roles/1").to route_to("founder/firm_roles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/founder/firm_roles/1").to route_to("founder/firm_roles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/founder/firm_roles/1").to route_to("founder/firm_roles#destroy", id: "1")
    end
  end
end
