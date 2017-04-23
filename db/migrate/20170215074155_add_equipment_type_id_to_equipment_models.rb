class AddEquipmentTypeIdToEquipmentModels < ActiveRecord::Migration[5.0]
  def change
    add_column :equipment_models,:equipment_type_id, :integer
  end
end
