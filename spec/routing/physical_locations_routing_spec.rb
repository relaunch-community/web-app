require "rails_helper"

RSpec.describe PhysicalLocationsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/physical_locations").to route_to("physical_locations#index")
    end

    it "routes to #new" do
      expect(get: "/physical_locations/new").to route_to("physical_locations#new")
    end

    it "routes to #show" do
      expect(get: "/physical_locations/1").to route_to("physical_locations#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/physical_locations/1/edit").to route_to("physical_locations#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/physical_locations").to route_to("physical_locations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/physical_locations/1").to route_to("physical_locations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/physical_locations/1").to route_to("physical_locations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/physical_locations/1").to route_to("physical_locations#destroy", id: "1")
    end
  end
end
