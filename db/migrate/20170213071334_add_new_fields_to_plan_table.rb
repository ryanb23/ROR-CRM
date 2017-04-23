class AddNewFieldsToPlanTable < ActiveRecord::Migration[5.0]
  def change
    add_column :plans,:price, :float
    add_column :plans,:created_by, :text
  end
end
