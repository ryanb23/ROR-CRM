class AddFileTypeToPatientDraftDatum < ActiveRecord::Migration[5.0]
  def change
  	add_column :patient_draft_data, :file_type, :string
  end
end
