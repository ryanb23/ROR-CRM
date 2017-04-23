class AddColumnToTempInsuranceDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :temp_insurance_details, :operation_status, :integer, default: 0
    add_column :temp_insurance_files, :operation_status, :integer, default: 0
  end
end
