class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.string :iban
      t.string :bic
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
