class CreateEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments do |t|
      t.string :name
      t.string :iban
      t.string :bic

      t.timestamps
    end
  end
end
