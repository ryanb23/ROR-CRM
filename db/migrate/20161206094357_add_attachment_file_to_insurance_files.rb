class AddAttachmentFileToInsuranceFiles < ActiveRecord::Migration
  def self.up
    change_table :insurance_files do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :insurance_files, :file
  end
end
