class AddCustomeRoleFieldInRole < ActiveRecord::Migration[5.0]
  def change
  	add_column :roles, :custom_role_id, :integer
  end
end
