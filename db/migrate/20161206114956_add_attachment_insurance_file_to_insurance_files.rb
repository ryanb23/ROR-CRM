class AddAttachmentInsuranceFileToInsuranceFiles < ActiveRecord::Migration
  def self.up
    change_table :insurance_files do |t|
      t.attachment :ins_file
    end
  end

  def self.down
    remove_attachment :insurance_files, :ins_file
  end
end
