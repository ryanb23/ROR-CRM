class RemoveInsuranceFileField < ActiveRecord::Migration[5.0]
  def change
  	remove_attachment :insurances, :insurance_file
  end
end
