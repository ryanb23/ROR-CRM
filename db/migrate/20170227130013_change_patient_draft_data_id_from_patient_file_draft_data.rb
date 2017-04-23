class ChangePatientDraftDataIdFromPatientFileDraftData < ActiveRecord::Migration[5.0]
  def change
  	# No need to rename. It is re-referenced by migration '20170301094456'
  	# rename_column :patient_file_draft_data, :patient_draft_data_id, :patient_draft_datum_id
  end
end
