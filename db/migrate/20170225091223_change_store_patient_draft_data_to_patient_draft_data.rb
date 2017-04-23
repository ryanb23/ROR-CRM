class ChangeStorePatientDraftDataToPatientDraftData < ActiveRecord::Migration[5.0]
  def change
  	rename_table :store_patient_draft_data, :patient_draft_data
  end
end
