class CreateProfessionalsUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :professionals_user_profiles do |t|
      # options via https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_reference
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true, index: { unique: true }
      t.timestamps
    end
  end
end
