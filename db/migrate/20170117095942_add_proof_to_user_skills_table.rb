class AddProofToUserSkillsTable < ActiveRecord::Migration[5.0]
  def self.up
    change_table :user_skills do |t|
      t.attachment :proof
    end
  end

  def self.down
    remove_attachment :user_skills, :proof
  end
end
