class AddDefaultValueToStatus < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :status, :integer, :default => 0
  end
end
