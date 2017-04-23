class CreateSalesmansPostalCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :salesmans_postal_codes do |t|
      t.references :user, foreign_key: true
      t.string :postal_code

      t.timestamps
    end
  end
end
