class Admin::PatientDraftDataController < Admin::BaseController
	include Authorizations
	skip_before_action :check_authorization , :only => [:save_upload_file]
	
	def create
		if params
			PatientDraftDatum.find(params[:patient_draft_id]).destroy if params[:patient_draft_id].present?
			@patient_draft_data = PatientDraftDatum.create(lastname: params[:lastname],firstname: params[:firstname],gender: params[:gender],birth_date: params[:dob],ethenic_group: params[:ethenic_group],social_security_number: params[:social_security_number],weight: params[:weight],height: params[:size],health_insurance: params[:health_insurance],medical_context: params[:medical_context],note: params[:note],email: params[:email],phone: params[:phone_number],password: params[:password],patient_agreement: params[:patient_aggrement],trusted_person_agreement: params[:trusted_person_agreement],trusted_person_name: params[:trusted_name],file_type: params[:file_type])
		end
		save_patient_file_draft_data if params[:file_id]
		render json: @patient_draft_data.id 
	end

	def destroy
		PatientDraftDatum.find_by(id: params[:id]).destroy
		redirect_to admin_forms_path
	end

	def edit
		@patient = PatientDraftDatum.find_by(id: params[:id])
		@patient_file = PatientFileDraftDatum.where("patient_draft_datum_id=?",@patient.id).pluck(:patient_file_file_name)
		@resource = Patient.new
		render 'admin/patients/edit'
	end

	def update
		if params
			# PatientDraftDatum.find(params[:patient_draft_id]).destroy if params[:patient_draft_id].present?
			@patient = PatientDraftDatum.find_by(id: params[:id])
			@patient_draft_data = @patient.update_attributes(lastname: params[:lastname],firstname: params[:firstname],gender: params[:gender],birth_date: params[:dob],ethenic_group: params[:ethenic_group],social_security_number: params[:social_security_number],weight: params[:weight],height: params[:size],health_insurance: params[:health_insurance],medical_context: params[:medical_context],note: params[:note],email: params[:email],phone: params[:phone_number],password: params[:password],patient_agreement: params[:patient_aggrement],trusted_person_agreement: params[:trusted_person_agreement],trusted_person_name: params[:trusted_name],file_type: params[:file_type])
		end
		save_patient_file_draft_data if params[:file_upload_name]
	end

	def save_upload_file
		ids = []
		file_data = []
		if params[:patinet_draft_id].present?
			@patient_draft_data = PatientDraftDatum.find_by(id: params[:patinet_draft_id])
			@patient_draft_data.patient_file_draft_data.destroy_all
			params[:files].each do |key, file|
				file_data << @patient_draft_data.patient_file_draft_data.create(patient_file: file)
			end
		else
			params[:files].each do |key, file|
				file_data << PatientFileDraftDatum.create(patient_file: file)
			end
		end
		render json: { ids: file_data.pluck(:id) }
	end

	private

	def save_patient_file_draft_data
		PatientFileDraftDatum.where("id IN (?)", params[:file_id].split(",")).update_all(patient_draft_datum_id: @patient_draft_data.id)
		# file_name = params[:file_upload_name].split(",")
		# file_size = params[:file_upload_size].split(",")
		# file_type = params[:file_upload_type].split(",")
		# i = 1
		# for i in 0..file_name.length-1
		# 	@patient_draft_data.patient_file_draft_data.create(patient_file_file_name: file_name[i],patient_file_content_type: file_type[i],patient_file_file_size: file_size[i],patient_file_updated_at: Time.now)
		# end
 	end
end
