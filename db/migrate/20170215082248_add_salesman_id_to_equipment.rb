class AddSalesmanIdToEquipment < ActiveRecord::Migration[5.0]
  def change
    add_column :equipment,:salesman_id, :integer
  end
end
