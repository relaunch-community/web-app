class AddRolesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :roles_mask, :integer
    add_index :users, :roles_mask
  end
end
