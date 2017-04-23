class AddAnotherFieldsToPatientDraftDatum < ActiveRecord::Migration[5.0]
  def change
  	add_column :patient_draft_data, :gender, :string
  	add_column :patient_draft_data, :birth_date, :date
  	add_column :patient_draft_data, :ethenic_group, :string
  	add_column :patient_draft_data, :social_security_number, :string
  	add_column :patient_draft_data, :weight, :integer
  	add_column :patient_draft_data, :height, :integer
  	add_column :patient_draft_data, :health_insurance, :string
  	add_column :patient_draft_data, :medical_context, :string
  	add_column :patient_draft_data, :note, :string
  	add_column :patient_draft_data, :email, :string
  	add_column :patient_draft_data, :phone, :string
  	add_column :patient_draft_data, :password, :string
  	add_column :patient_draft_data, :patient_agreement, :string
  	add_column :patient_draft_data, :trusted_person_agreement, :string
  	add_column :patient_draft_data, :trusted_person_name, :string
  end
end
