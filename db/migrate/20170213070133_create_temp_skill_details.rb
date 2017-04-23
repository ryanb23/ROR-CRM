class CreateTempSkillDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_skill_details do |t|
      t.integer :user_temp_detail_id
      t.string :name
      t.string :comment

      t.timestamps
    end
  end
end
