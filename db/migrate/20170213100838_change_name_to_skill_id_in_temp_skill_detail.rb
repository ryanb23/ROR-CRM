class ChangeNameToSkillIdInTempSkillDetail < ActiveRecord::Migration[5.0]
  def change
  	rename_column :temp_skill_details, :name, :skill_id
  	change_column :temp_skill_details, :skill_id, :integer
  end
end
