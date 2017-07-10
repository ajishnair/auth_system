class CreateRoleAccesses < ActiveRecord::Migration
  def change
    create_table :role_accesses do |t|
      t.references :role, index: true
      t.references :access, index: true

      t.timestamps null: false
    end
    add_foreign_key :role_accesses, :roles
    add_foreign_key :role_accesses, :accesses
  end
end
