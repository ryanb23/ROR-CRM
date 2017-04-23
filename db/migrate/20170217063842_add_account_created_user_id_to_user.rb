class AddAccountCreatedUserIdToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :account_created_user_id, :integer
  end
end
