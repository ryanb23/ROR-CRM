class AddDefaultValueToFormStatus < ActiveRecord::Migration[5.0]
  def change
  	change_column :forms, :status, :integer, :default => 1
  end
end
