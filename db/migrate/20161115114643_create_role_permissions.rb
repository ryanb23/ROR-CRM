class CreateRolePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :role_permissions do |t|
      t.references :role, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end
