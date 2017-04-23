class AddAttachmentFileToFormFiles < ActiveRecord::Migration
  def self.up
    change_table :form_files do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :form_files, :file
  end
end
