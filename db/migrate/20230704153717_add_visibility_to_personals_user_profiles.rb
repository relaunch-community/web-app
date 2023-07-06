class AddVisibilityToPersonalsUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :personals_user_profiles,
               :visibility,
               :integer
    add_index :personals_user_profiles, :visibility
  end
end
