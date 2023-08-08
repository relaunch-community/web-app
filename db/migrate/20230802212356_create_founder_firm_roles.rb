class CreateFounderFirmRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :founder_firm_roles, id: :uuid do |t|
      t.string :title, null: false
      t.decimal :ownership_percentage, null: false
      t.boolean :ownership_confirmation_checkbox, null: false, default: false
      t.integer :visibility, null: false

      t.datetime :joined_at
      t.datetime :departed_on

      t.belongs_to :founder_firm, type: :uuid, null: false, foreign_key: true
      t.belongs_to :professional_profile, null: false, foreign_key: { to_table: :professionals_user_profiles }

      t.timestamps
    end
  end
end
