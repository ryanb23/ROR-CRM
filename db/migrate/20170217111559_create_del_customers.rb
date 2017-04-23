class CreateDelCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :del_customers do |t|
      t.integer :customer_id
      t.integer :delegate_customer_id

      t.timestamps
    end
  end
end
