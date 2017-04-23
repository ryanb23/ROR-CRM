class AddFieldsToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :workflow_delay, :integer
    add_column :settings, :technical_provider_price, :float
    add_column :settings, :technical_provider_delay, :integer
  end
end
