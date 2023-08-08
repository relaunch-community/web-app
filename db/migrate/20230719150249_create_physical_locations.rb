class CreatePhysicalLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :physical_locations, id: :uuid do |t|
      t.text :city
      t.text :state_subdivision
      t.text :country

      t.timestamps
    end
  end
end
