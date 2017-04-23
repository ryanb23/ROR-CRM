class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :card_number
      t.date :expire_on
      t.decimal :amount
      t.integer :status
      t.references :form, foreign_key: true

      t.timestamps
    end
  end
end
