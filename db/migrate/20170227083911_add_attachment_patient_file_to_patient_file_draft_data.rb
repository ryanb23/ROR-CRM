class AddAttachmentPatientFileToPatientFileDraftData < ActiveRecord::Migration
  def self.up
    change_table :patient_file_draft_data do |t|
      t.attachment :patient_file
    end
  end

  def self.down
    remove_attachment :patient_file_draft_data, :patient_file
  end
end
