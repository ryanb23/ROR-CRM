class PatientFileDraftDatum < ApplicationRecord
  belongs_to :patient_draft_data
  has_attached_file :patient_file
  do_not_validate_attachment_file_type :patient_file
end
