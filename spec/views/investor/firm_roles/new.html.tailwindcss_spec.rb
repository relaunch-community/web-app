require "rails_helper"

RSpec.describe "investor/firm_roles/new" do
  before do
    assign(:investor_firms, create_list(:investor_firm, 10))
    assign(:investor_firm_role, build(:investor_firm_role))
  end

  it "renders new investor_firm_role form" do
    render

    assert_select "form[action=?][method=?]", investor_firm_roles_path, "post" do
      assert_select "input[name=?]", "investor_firm_role[title]"

      assert_select "input[name=?]", "investor_firm_role[why_here]"

      assert_select "input[name=?]", "investor_firm_role[investment_target_stage]"
    end
  end
end
