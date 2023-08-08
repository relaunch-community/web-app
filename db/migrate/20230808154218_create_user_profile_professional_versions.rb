class CreateUserProfileProfessionalVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profile_professional_versions do |t|
      t.string :item_type, null: false
      t.uuid :item_id, null: false
      t.string :event, null: false
      t.string :whodunnit
      t.json :object # Full object changes

      t.datetime :created_at
    end

    add_index :user_profile_professional_versions,
              %i[item_type item_id],
              name: "index_up_professional_versions_on_item_type_and_item_id"
  end
end
