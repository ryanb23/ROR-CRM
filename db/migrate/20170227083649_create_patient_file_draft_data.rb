class CreatePatientFileDraftData < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_file_draft_data do |t|
      t.references :patient_draft_data, foreign_key: true

      t.timestamps
    end
  end
end
