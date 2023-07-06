class AddPronounVisibilityToPersonalsUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :personals_user_profiles, :pronoun_visibility, :boolean
    add_index :personals_user_profiles, :pronoun_visibility
  end
end
