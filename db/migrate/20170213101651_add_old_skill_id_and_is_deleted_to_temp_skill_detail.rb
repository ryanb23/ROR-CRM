class AddOldSkillIdAndIsDeletedToTempSkillDetail < ActiveRecord::Migration[5.0]
  def change
  	add_reference :temp_skill_details, :user_skill, index: true
  	add_column :temp_skill_details, :operation_status, :integer, default: 0
  end
end
