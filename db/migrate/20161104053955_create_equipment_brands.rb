class CreateEquipmentBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_brands do |t|
      t.string :name
      t.references :equipment_type, foreign_key: true

      t.timestamps
    end
  end
end
