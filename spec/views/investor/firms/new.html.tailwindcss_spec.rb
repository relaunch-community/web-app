require "rails_helper"

RSpec.describe "investor/firms/new" do
  before do
    assign(:investor_firm, Investor::Firm.new(
      name: "MyText",
      thesis: "MyText",
      overview: "MyText",
      site_url: "MyText"
    ))
  end

  it "renders new investor_firm form" do
    render

    assert_select "form[action=?][method=?]", investor_firms_path, "post" do
      assert_select "input[name=?]", "investor_firm[name]"

      assert_select "input[name=?]", "investor_firm[thesis]"

      assert_select "textarea[name=?]", "investor_firm[overview]"

      assert_select "input[name=?]", "investor_firm[site_url]"
    end
  end
end
