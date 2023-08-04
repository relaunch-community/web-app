class AddProfessionalProfileIdToInvestorFirms < ActiveRecord::Migration[7.0]
  def change
    add_reference :investor_firms,
                  :professional_profile,
                  null: true,
                  foreign_key: { to_table: :professionals_user_profiles }
  end
end
