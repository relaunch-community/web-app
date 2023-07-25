require "rails_helper"

RSpec.describe Investor::FirmRolesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/investor/firm_roles").to route_to("investor/firm_roles#index")
    end

    it "routes to #new" do
      expect(get: "/investor/firm_roles/new").to route_to("investor/firm_roles#new")
    end

    it "routes to #show" do
      expect(get: "/investor/firm_roles/1").to route_to("investor/firm_roles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/investor/firm_roles/1/edit").to route_to("investor/firm_roles#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/investor/firm_roles").to route_to("investor/firm_roles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/investor/firm_roles/1").to route_to("investor/firm_roles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/investor/firm_roles/1").to route_to("investor/firm_roles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/investor/firm_roles/1").to route_to("investor/firm_roles#destroy", id: "1")
    end
  end
end
