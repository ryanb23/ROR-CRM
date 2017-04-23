class ChangeTypeNameFromSetting < ActiveRecord::Migration[5.0]
  def change
  	rename_column :settings, :type, :user_type
  end
end
