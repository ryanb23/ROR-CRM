class AddFormOrphanIdToPatientDraftData < ActiveRecord::Migration[5.0]
  def change
    add_column :patient_draft_data, :form_orphan_id, :integer , :limit => 8
  end
end
