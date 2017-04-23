class CreatePatientTemporaryFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_temporary_files do |t|
      t.integer :form_orphan_id , :limit => 8

      t.timestamps
    end
  end
end
