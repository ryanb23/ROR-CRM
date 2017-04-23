class CreateInvoicesPatients < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices_patients do |t|
      t.float :amount
      t.integer :patient_id
      t.integer :status
      t.integer :form_id

      t.timestamps
    end
  end
end
