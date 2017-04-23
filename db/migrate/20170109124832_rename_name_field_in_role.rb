class RenameNameFieldInRole < ActiveRecord::Migration[5.0]
  def change
  	rename_column :roles, :name, :name_en
  end
end
