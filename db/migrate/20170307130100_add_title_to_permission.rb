class AddTitleToPermission < ActiveRecord::Migration[5.0]
  def change
    add_column :permissions, :title, :string
  end
end
