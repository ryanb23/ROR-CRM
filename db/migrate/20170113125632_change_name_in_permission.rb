class ChangeNameInPermission < ActiveRecord::Migration[5.0]
  def change
  	rename_column :permissions, :name, :name_en
  	add_column :permissions, :name_fr, :string
  end
end
