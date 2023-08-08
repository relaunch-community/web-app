class CreatePersonalsUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :personals_user_profiles, id: :uuid do |t|
      # options via https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_reference
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true, index: { unique: true }

      # Names
      t.text :first_name
      t.text :last_name

      # Pronouns
      t.text :freeform_pronouns
      t.text :prepopulated_pronouns, null: false

      t.string :headline, limit: 128
      t.string :overview, limit: 1024

      t.text :original_linkedin_url
      t.text :linkedin_url

      t.string :original_email_address, null: false
      t.string :email_address, null: false, limit: 319

      t.timestamps
    end

    add_index :personals_user_profiles, :email_address, unique: true
  end
end
