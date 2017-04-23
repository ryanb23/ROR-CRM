class PatientDraftDatum < ApplicationRecord
	has_many :patient_file_draft_data,dependent: :destroy
end
