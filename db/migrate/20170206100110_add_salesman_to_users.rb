class AddSalesmanToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:salesman_id, :text
  end
end
