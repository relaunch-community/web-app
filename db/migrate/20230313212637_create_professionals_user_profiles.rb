class CreateProfessionalsUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :professionals_user_profiles do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
