class CreateInvestorFirmRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :investor_firm_roles, id: :uuid do |t|
      t.belongs_to :professional_profile, null: false, type: :uuid, foreign_key: { to_table: :professionals_user_profiles }
      t.belongs_to :investor_firm, type: :uuid, null: false, foreign_key: true
      t.belongs_to :physical_location, type: :uuid, foreign_key: { to_table: :physical_locations }

      t.text :title
      t.text :why_here

      t.text :investment_target_stage
      t.text :investment_target_customer # b2b b2c
      t.text :investment_target_industries
      t.text :investment_target_locations

      t.timestamps
    end
  end
end
