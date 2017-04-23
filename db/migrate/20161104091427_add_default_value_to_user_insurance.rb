class AddDefaultValueToUserInsurance < ActiveRecord::Migration[5.0]
  def change
  	change_column :user_insurances, :active, :boolean, :default => false
  end
end
