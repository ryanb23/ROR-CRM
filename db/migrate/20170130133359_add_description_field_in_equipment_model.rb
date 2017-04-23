class AddDescriptionFieldInEquipmentModel < ActiveRecord::Migration[5.0]
  def change
  	add_column :equipment_models,:description, :text
  end
end
