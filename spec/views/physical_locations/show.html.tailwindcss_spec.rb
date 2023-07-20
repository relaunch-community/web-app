require "rails_helper"

RSpec.describe "physical_locations/show" do
  before do
    assign(:physical_location, PhysicalLocation.create!(
      city: "MyText",
      state_subdivision: "MyText",
      country: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
