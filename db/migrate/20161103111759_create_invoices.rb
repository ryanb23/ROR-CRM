class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.datetime :invoice_date
      t.decimal :invoice_amount
      t.references :subscription, foreign_key: true

      t.timestamps
    end
  end
end
