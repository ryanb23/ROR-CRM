class Admin::PatientsController < Admin::BaseController
	include Authorizations
	def create
		if Patient.exists?(social_security_number: params[:patient][:social_security_number])
			@patient = Patient.find_by(social_security_number: params[:patient][:social_security_number])
			@user = User.find_by(id: @patient.user_id)
			ActiveRecord::Base.transaction do
				create_form if @patient
			end
		else
			@resource = Patient.new(resource_params)
			@user = User.new(email: params[:user][:email],password: params[:user][:password],first_name: params[:user][:firstname],last_name: params[:user][:lastname],phone: params[:user][:phone_number],birth_date: params[:user][:date_of_birth],gender: params[:user][:gender], is_patient: true)
			ActiveRecord::Base.transaction do
				if @user.save
					@user.roles << Role.patient.first
					@resource.save
					@patient = Patient.find(@resource.id)
					@patient.update_attributes(user: @user)
					if @patient
						create_form
					end
				else
					render 'new'
				end
			end
		end
		destroy_patient_draft_data if params[:patient_draft_data_id]
	end

	# def index
	# 	@patient_data = Patient.all
	# 	@patient_draft_data = PatientDraftDatum.all
	# 	@all_items = [@patient_data,@patient_draft_data].flatten.sort_by{ |data|   data.updated_at}
	# 	@all_patient_data = @all_items.reverse
	# end
	

	private

  def permitted_attributes
    ["ethenic_group", "weight", "height", "social_security_number", "patient_agreement", "trusted_person_name", "health_insurance", "country"]
  end
  def resource_params
    params.fetch(resource_name, {}).permit(permitted_attributes)
	end

	def create_form
		@form = @patient.patient_forms.new(form_type: params[:form][:file_type],medical_context: params[:form][:medical_context],note: params[:note],status: 2)
		if current_user && current_user.has_role?("customer")
			Form.update_customer_id(@form,current_user)
			Form.create_name_and_status(@form,@patient,@user)
		elsif current_user && current_user.has_role?("delegated_customer")
			Form.update_del_customer_id(@form,current_user)
			Form.create_name_with_del_customer(@form,@patient,@user,current_user)
		else
			Form.create_name_and_status(@form,@patient,@user)
		end
		@form.save
		@form.form_statuses.create(status: @form.status,patient_id: @form&.patient_id,provider_id: @form&.provider_id,supervisor_id: @form&.supervisor_id)
		if @form
			create_form_file
		else
			redirect_to admin_forms_path
		end
	end

	def create_form_file
		if params[:file].present?
			params[:file]&.each do |file|
				@form.form_files.create(file: file)
			end
		elsif params["competence-photo-path "].present?
			files = PatientFileDraftDatum.where("patient_file_file_name IN (?) and patient_draft_datum_id = ?" ,params["competence-photo-path "].split(','),params[:patient_draft_data_id])
			files.each do |file|
				file.patient_file =  file.patient_file
				file.save
				@form.form_files.create(file: file.patient_file)
			end
		end
		redirect_to admin_forms_path
	end

	def destroy_patient_draft_data
		PatientDraftDatum.find_by(id: params[:patient_draft_data_id]).destroy if PatientDraftDatum.find_by(id: params[:patient_draft_data_id]).present?
	end
end