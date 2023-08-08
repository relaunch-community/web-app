class CreateInvestorFirms < ActiveRecord::Migration[7.0]
  def change
    create_table :investor_firms, id: :uuid do |t|
      t.text :name
      t.text :slug
      t.text :thesis
      t.text :overview
      t.text :site_url

      t.belongs_to :physical_location, type: :uuid, foreign_key: { to_table: :physical_locations }

      t.timestamps
    end

    add_index :investor_firms, :name, unique: true
    add_index :investor_firms, :slug, unique: true
  end
end
