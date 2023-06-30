class AddHashIdToProfessionalsUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :professionals_user_profiles, :hash_id, :uuid, unique: true
  end
end
