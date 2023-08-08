class CreateUserProfilePersonalVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profile_personal_versions do |t|
      t.string :item_type, null: false
      t.uuid :item_id, null: false
      t.string :event, null: false
      t.string :whodunnit
      t.json :object # Full object changes

      t.datetime :created_at
    end

    add_index :user_profile_personal_versions, %i[item_type item_id]
  end
end
