class AddAttachmentInsFileToTempInsuranceFiles < ActiveRecord::Migration
  def self.up
    change_table :temp_insurance_files do |t|
      t.attachment :ins_file
    end
  end

  def self.down
    remove_attachment :temp_insurance_files, :ins_file
  end
end
