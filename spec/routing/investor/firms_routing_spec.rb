require "rails_helper"

RSpec.describe Investor::FirmsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/investor/firms").to route_to("investor/firms#index")
    end

    it "routes to #new" do
      expect(get: "/investor/firms/new").to route_to("investor/firms#new")
    end

    it "routes to #show" do
      expect(get: "/investor/firms/1").to route_to("investor/firms#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/investor/firms/1/edit").to route_to("investor/firms#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/investor/firms").to route_to("investor/firms#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/investor/firms/1").to route_to("investor/firms#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/investor/firms/1").to route_to("investor/firms#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/investor/firms/1").to route_to("investor/firms#destroy", id: "1")
    end
  end
end
