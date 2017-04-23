class CreateUserTempDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :user_temp_details do |t|
      t.integer :user_id
      t.text :speciality_ids
      t.integer :establishment_id
      t.integer :establishment_service_id

      t.timestamps
    end
  end
end
