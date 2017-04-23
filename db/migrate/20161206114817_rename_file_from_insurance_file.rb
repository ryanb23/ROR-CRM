class RenameFileFromInsuranceFile < ActiveRecord::Migration[5.0]
  def change
  	remove_attachment :insurance_files, :file
  end
end
