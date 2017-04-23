class AddAttachmentInsuranceFileToInsurances < ActiveRecord::Migration
  def self.up
    change_table :insurances do |t|
      t.attachment :insurance_file
    end
  end

  def self.down
    remove_attachment :insurances, :insurance_file
  end
end
