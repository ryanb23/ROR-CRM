class AddCustomeFieldsInSetting < ActiveRecord::Migration[5.0]
  def change
  	add_column :settings, :file_type, :integer
  	add_column :settings, :workflow_type, :integer
  	add_column :settings, :payment_type, :integer
  	add_column :settings, :billing_price, :float
  	add_column :settings, :payment_waiting_delay, :integer
  	add_column :settings, :analysis_delay, :integer
  end
end
