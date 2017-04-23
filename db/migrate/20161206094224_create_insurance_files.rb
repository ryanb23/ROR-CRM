class CreateInsuranceFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :insurance_files do |t|
      t.references :insurance, foreign_key: true

      t.timestamps
    end
  end
end
