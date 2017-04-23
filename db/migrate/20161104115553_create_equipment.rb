class CreateEquipment < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment do |t|
      t.string :serial_number
      t.datetime :acquisition_date
      t.datetime :start_date
      t.datetime :end_date
      t.integer :incident
      t.string :leasing_reference
      t.integer :status
      t.references :equipment_type, foreign_key: true
      t.references :equipment_model, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
