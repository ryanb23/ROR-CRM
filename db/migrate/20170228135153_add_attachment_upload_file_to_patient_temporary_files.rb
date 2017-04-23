class AddAttachmentUploadFileToPatientTemporaryFiles < ActiveRecord::Migration
  def self.up
    change_table :patient_temporary_files do |t|
      t.attachment :upload_file
    end
  end

  def self.down
    remove_attachment :patient_temporary_files, :upload_file
  end
end
