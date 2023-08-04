require "rails_helper"

RSpec.describe Founder::FirmsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/founder/firms").to route_to("founder/firms#index")
    end

    it "routes to #new" do
      expect(get: "/founder/firms/new").to route_to("founder/firms#new")
    end

    it "routes to #show" do
      expect(get: "/founder/firms/1").to route_to("founder/firms#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/founder/firms/1/edit").to route_to("founder/firms#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/founder/firms").to route_to("founder/firms#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/founder/firms/1").to route_to("founder/firms#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/founder/firms/1").to route_to("founder/firms#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/founder/firms/1").to route_to("founder/firms#destroy", id: "1")
    end
  end
end
