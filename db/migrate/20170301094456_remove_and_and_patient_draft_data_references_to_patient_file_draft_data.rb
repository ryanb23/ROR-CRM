class RemoveAndAndPatientDraftDataReferencesToPatientFileDraftData < ActiveRecord::Migration[5.0]
  def change
    remove_reference :patient_file_draft_data, :patient_draft_data, foreign_key: true
    add_reference :patient_file_draft_data, :patient_draft_datum, foreign_key: true
  end
end
