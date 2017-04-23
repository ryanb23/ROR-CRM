class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :country_code
      t.string :telephone_code

      t.timestamps
    end
  end
end
