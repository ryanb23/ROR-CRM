class CreateUserInsurances < ActiveRecord::Migration[5.0]
  def change
    create_table :user_insurances do |t|
      t.references :user, foreign_key: true
      t.references :insurance, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
