class AddProviderPendingAtToForm < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :provider_pending_at, :datetime
  end
end
