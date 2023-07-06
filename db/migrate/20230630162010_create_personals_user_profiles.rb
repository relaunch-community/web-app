class CreatePersonalsUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :personals_user_profiles do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true

      t.column :hash_id, :uuid, unique: true

      # Names
      t.text :first_name
      t.text :last_name

      # Pronouns
      t.text :freeform_pronouns
      t.text :prepopulated_pronouns, null: false

      t.string :headline, limit: 128
      t.string :overview, limit: 1024

      t.text :linkedin_url

      t.string :email_address, null: false, limit: 319, unique: true

      t.timestamps
    end
  end
end
