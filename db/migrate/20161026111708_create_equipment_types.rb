class CreateEquipmentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
