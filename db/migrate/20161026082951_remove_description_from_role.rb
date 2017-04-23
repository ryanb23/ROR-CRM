class RemoveDescriptionFromRole < ActiveRecord::Migration[5.0]
  def change
    remove_column :roles, :description, :string
  end
end
