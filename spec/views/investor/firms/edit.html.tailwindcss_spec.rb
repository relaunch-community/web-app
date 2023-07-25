require "rails_helper"

RSpec.describe "investor/firms/edit" do
  let(:investor_firm) { create(:investor_firm) }

  before do
    assign(:investor_firm, investor_firm)
  end

  it "renders the edit investor_firm form" do
    render

    assert_select "form[action=?][method=?]", investor_firm_path(investor_firm), "post" do
      assert_select "input[name=?]", "investor_firm[name]"

      assert_select "input[name=?]", "investor_firm[thesis]"

      assert_select "textarea[name=?]", "investor_firm[overview]"

      assert_select "input[name=?]", "investor_firm[site_url]"
    end
  end
end
