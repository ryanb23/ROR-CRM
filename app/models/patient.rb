class Patient < ApplicationRecord
	has_many :form_statuses,dependent: :destroy
	has_many :invoices_patients
	has_many :forms, through: :invoices_patients ,dependent: :destroy
	has_many :patient_forms, class_name: "Form", dependent: :destroy
	belongs_to :user
	# validates_associated :user

	enum patient_agreement: {"normal_patient_agreement" => 1,"trust_person_agreement" => 2}
	validates :social_security_number, :patient_agreement ,presence: true
end
