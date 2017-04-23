class CreateTempInsuranceFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_insurance_files do |t|
      t.integer :temp_insurance_detail_id

      t.timestamps
    end
  end
end
