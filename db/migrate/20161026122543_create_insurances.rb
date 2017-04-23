class CreateInsurances < ActiveRecord::Migration[5.0]
  def change
    create_table :insurances do |t|
      t.string :name
      t.datetime :end_date

      t.timestamps
    end
  end
end
