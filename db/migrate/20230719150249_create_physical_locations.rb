class CreatePhysicalLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :physical_locations do |t|
      # I'm just not a fan of using uuid as pkey for joins etc.
      t.column :hash_id, :uuid, unique: true

      t.text :city
      t.text :state_subdivision
      t.text :country

      t.timestamps
    end
  end
end
