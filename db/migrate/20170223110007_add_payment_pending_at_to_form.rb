class AddPaymentPendingAtToForm < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :payment_pending_at, :datetime
  end
end
