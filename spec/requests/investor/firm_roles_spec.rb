require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/investor/firm_roles" do
  # This should return the minimal set of attributes required to create a valid
  # Investor::FirmRole. As you add validations to Investor::FirmRole, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
  let(:user) { create(:user) }

  around do |ex|
    # https://stackoverflow.com/questions/10121835/how-do-i-simulate-a-login-with-rspec
    # https://stackoverflow.com/questions/27284657/undefined-method-env-for-nilnilclass-in-setup-controller-for-warden-error
    # https://rubydoc.info/gems/rspec-core/RSpec%2FCore%2FHooks:around
    login_as user
    ex.run
    logout
  end

  describe "GET /index" do
    it "renders a successful response" do
      Investor::FirmRole.create! valid_attributes
      get investor_firm_roles_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      firm_role = Investor::FirmRole.create! valid_attributes
      get investor_firm_role_url(firm_role)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_investor_firm_role_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      firm_role = Investor::FirmRole.create! valid_attributes
      get edit_investor_firm_role_url(firm_role)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Investor::FirmRole" do
        expect {
          post investor_firm_roles_url, params: { investor_firm_role: valid_attributes }
        }.to change(Investor::FirmRole, :count).by(1)
      end

      it "redirects to the created investor_firm_role" do
        post investor_firm_roles_url, params: { investor_firm_role: valid_attributes }
        expect(response).to redirect_to(investor_firm_role_url(Investor::FirmRole.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Investor::FirmRole" do
        expect {
          post investor_firm_roles_url, params: { investor_firm_role: invalid_attributes }
        }.not_to change(Investor::FirmRole, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post investor_firm_roles_url, params: { investor_firm_role: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested investor_firm_role" do
        firm_role = Investor::FirmRole.create! valid_attributes
        patch investor_firm_role_url(firm_role), params: { investor_firm_role: new_attributes }
        firm_role.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the investor_firm_role" do
        firm_role = Investor::FirmRole.create! valid_attributes
        patch investor_firm_role_url(firm_role), params: { investor_firm_role: new_attributes }
        firm_role.reload
        expect(response).to redirect_to(investor_firm_role_url(firm_role))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        firm_role = Investor::FirmRole.create! valid_attributes
        patch investor_firm_role_url(firm_role), params: { investor_firm_role: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested investor_firm_role" do
      firm_role = Investor::FirmRole.create! valid_attributes
      expect {
        delete investor_firm_role_url(firm_role)
      }.to change(Investor::FirmRole, :count).by(-1)
    end

    it "redirects to the investor_firm_roles list" do
      firm_role = Investor::FirmRole.create! valid_attributes
      delete investor_firm_role_url(firm_role)
      expect(response).to redirect_to(investor_firm_roles_url)
    end
  end
end
