class CreateStorePatientDraftData < ActiveRecord::Migration[5.0]
  def change
    create_table :store_patient_draft_data do |t|
      t.string :lastname
      t.string :firstname

      t.timestamps
    end
  end
end
