class RenameFieldUserStatusToDeleted < ActiveRecord::Migration[5.0]
  def change
  	rename_column :users, :user_status, :deleted
  end
end
