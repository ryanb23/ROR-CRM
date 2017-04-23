class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.references :user
      t.string :ethenic_group
      t.integer :weight, :limit => 3
      t.integer :height, :limit => 3
      t.string :social_security_number
      t.integer :patient_agreement, :limit => 3
      t.string :trusted_person_name

      t.timestamps
    end
  end
end
