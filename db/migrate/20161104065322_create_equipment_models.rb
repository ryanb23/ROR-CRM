class CreateEquipmentModels < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_models do |t|
      t.string :name
      t.references :equipment_brand, foreign_key: true

      t.timestamps
    end
  end
end
