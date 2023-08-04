class CreateFounderFirms < ActiveRecord::Migration[7.0]
  def change
    create_table :founder_firms, id: :uuid do |t|
      t.string :name, null: false
      t.text :target_problem, null: false
      t.text :short_description, null: false
      t.text :long_description
      t.text :site_url
      t.text :slug

      t.string :target_customer
      t.string :target_industries
      t.string :target_locations

      t.datetime :founded_at
      t.datetime :ended_on

      t.integer :visibility, null: false
      # If visible, what fields are allowed?
      t.json :field_visibility

      # state machine & review
      t.string :review_state
      t.integer :firm_kind, null: false # for enum
      t.text :firm_kind_justification # for enum

      t.references :headquarters_location, index: true, foreign_key: { to_table: :physical_locations }
      t.references :incorporation_location, index: true, foreign_key: { to_table: :physical_locations }
      t.belongs_to :professional_profile, null: true, foreign_key: { to_table: :professionals_user_profiles }

      t.timestamps
    end

    add_index :founder_firms, :name, unique: true
    add_index :founder_firms, :slug, unique: true

    add_index :founder_firms, :review_state
    add_index :founder_firms, :visibility
  end
end
