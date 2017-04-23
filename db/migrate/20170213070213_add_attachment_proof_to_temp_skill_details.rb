class AddAttachmentProofToTempSkillDetails < ActiveRecord::Migration
  def self.up
    change_table :temp_skill_details do |t|
      t.attachment :proof
    end
  end

  def self.down
    remove_attachment :temp_skill_details, :proof
  end
end
