class CreateTempInsuranceDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_insurance_details do |t|
      t.integer :user_temp_detail_id
      t.string :ins_name
      t.datetime :ins_end_date

      t.timestamps
    end
  end
end
