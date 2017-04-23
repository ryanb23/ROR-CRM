class RenameNameFieldInSkill < ActiveRecord::Migration[5.0]
  def change
    rename_column :skills, :name, :name_fr
  end
end
