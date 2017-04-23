class AddReferenceToTempInsuranceDetails < ActiveRecord::Migration[5.0]
  def change
    add_reference :temp_insurance_details, :insurance, foreign_key: true
    add_reference :temp_insurance_files, :insurance_file, foreign_key: true
  end
end
