class AddNameEnInSkill < ActiveRecord::Migration[5.0]
  def change
    add_column :skills, :name_en, :string
  end
end
