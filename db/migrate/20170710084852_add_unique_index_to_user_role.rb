class AddUniqueIndexToUserRole < ActiveRecord::Migration
  def change
  	add_index :user_roles, [:role_id, :user_id], :unique => true
  end
end
