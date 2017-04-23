class AddPaymentResponseToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :payment_response, :text
  end
end
