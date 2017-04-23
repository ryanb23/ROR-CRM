class AddAccountCreatedSalesmanIdToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :account_created_salesman_id, :integer
  end
end
