class CreateFounderFirmReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :founder_firm_reviews do |t|
      t.json :proposed_changes
      t.text :proposed_changes_comments
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true
      # I don't want to deal with polymorphic fun
      t.belongs_to :founder_firm, type: :uuid, null: false, foreign_key: true
      t.string :delivery_state

      t.timestamps
    end
  end
end
