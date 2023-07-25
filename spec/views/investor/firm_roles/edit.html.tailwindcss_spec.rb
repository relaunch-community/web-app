require "rails_helper"

RSpec.describe "investor/firm_roles/edit" do
  let(:investor_firms) { create_list(:investor_firm, 5) }
  let(:investor_firm_role) { create(:investor_firm_role) }

  before do
    assign(:investor_firm_role, investor_firm_role)
    assign(:investor_firms, investor_firms)
  end

  it "renders the edit investor_firm_role form" do
    render

    assert_select "form[action=?][method=?]", investor_firm_role_path(investor_firm_role), "post" do
      assert_select "input[name=?]", "investor_firm_role[title]"

      assert_select "input[name=?]", "investor_firm_role[why_here]"

      assert_select "input[name=?]", "investor_firm_role[investment_target_stage]"
    end
  end
end
