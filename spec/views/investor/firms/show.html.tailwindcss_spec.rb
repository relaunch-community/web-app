require "rails_helper"

RSpec.describe "investor/firms/show" do
  let(:investor_firm) { create(:investor_firm) }
  let(:investor_firm_roles) do
    create_list(:investor_firm_role, 5, investor_firm: investor_firm)
  end

  before do
    assign(:investor_firm, investor_firm)
    assign(:investor_firm_roles, investor_firm_roles)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Investor Profile - /)
  end
end
