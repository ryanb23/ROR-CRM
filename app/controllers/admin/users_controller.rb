class Admin::UsersController < Admin::BaseController
	# skip_authorize_resource :only => :checkpostalcode
	include Authorizations
	include ApplicationHelper
	skip_before_action :check_authorization , :only => [:checkpostalcode,:pending_accounts,:deactive_accounts,:active_accounts,:get_del_cust_by_country,:show_signature,:delete_signature,:set_current_role]
	protect_from_forgery with: :null_session
	# load_and_authorize_resource
	# before_filter :load_permissions
	# before_filter :check_role,:check_status, only: [:create,:update]
  before_action :check_status, only: [:create,:update]
	before_action :get_account, only: [:active_account_form,:update_account_status]
  after_action :set_redirect_path, only: [:pending_accounts, :active_accounts, :deactive_accounts]


	def class_search_params
		params.slice(:first_name, :last_name, :establishment_id, :establishment_service_id, :emp_status, :speciality_id, :role_id)
	end
	def search
		super do |resource|

			if params[:role_id].present? && params[:speciality_id].present?
				@resources= resource.joins(:roles, :specialities).where(user_roles: {role_id: params[:role_id]}).where(specialities_users: {speciality_id: params[:speciality_id]})
			elsif params[:role_id].present?
				@resources= resource.joins(:roles).where(user_roles: {role_id: params[:role_id]})
			elsif params[:speciality_id].present?
				@resources= resource.joins(:specialities).where(specialities_users: {speciality_id: params[:speciality_id]})
			end
		end
	end

	def new
		super
		if current_user.has_role?("salesman_before_sale") || current_user.has_role?("salesman")
	    pa = current_user.salesmans_postal_codes.all.pluck(:postal_code)
	    @del_customers = Role.delegated_customer.first.users.where(postal_code: pa)
	  else
	  	@del_customers = Role.delegated_customer.first.users
	  end
	end

	def create
		super do |resource|
      if resource_class == User
        if( params[:user][:role_ids] & Role.customer.ids.map(&:to_s) ).any?
          delegate_customer_ids = params[:user][:del_customers_attributes].first[1].values.join(' ').split(' ')
          delegate_customer_ids.each do |id|
            DelCustomer.create({customer_id: resource.id, delegate_customer_id: id})
          end
        end
      end
      if current_user.has_role?("salesman") && (resource.has_role?("customer") || resource.has_role?("technical_service_provider"))
        resource.update_attributes(account_created_salesman_id: current_user.id)
      else
        resource.update_attributes(account_created_user_id: current_user.id)
      end
		  @roles = Role.where("name_en LIKE ?", "Salesman%")
		  @current_user_role = UserRole.where("user_id = ?", current_user.id)
		  @roles.each do |role|
			  @current_user_role.each do |current_role|
				  if(current_role.role_id == role.id)
					 add_salesman_id
				  end
			  end
			end
		 create_postal
    end
	end

	def edit
    @postal_code = SalesmansPostalCode.where(user_id: @resource.id).pluck(:postal_code)
    @temp_data = @resource.user_temp_detail
    @speciality_data = Speciality.where("id IN (?)",@temp_data&.speciality_ids)
    @temp_skill_details = @temp_data&.temp_skill_details || TempSkillDetail.none
    # @temp_data = UserTempDetail.find_by(user_id: @resource.id)
    @temp_insurance_details = @temp_data&.temp_insurance_details || TempInsuranceDetail.none

      if current_user.has_role?("salesman_before_sale") || current_user.has_role?("salesman")
  	    pa = current_user.salesmans_postal_codes.all.pluck(:postal_code)
  	    @del_customers = Role.delegated_customer.first.users.where(postal_code: pa)
  	  elsif @resource.establishment.present?
  	  	@del_customers = Role.delegated_customer.first.users.where(id: @resource.establishment.users.ids)
  	  elsif @resource.country.present?
          @del_customers = Role.delegated_customer.first.users.where(country: @resource.country)
  	  else
  	  	@del_customers = Role.delegated_customer.first.users
  	  end

      if params[:role_id].present? && params[:speciality_id].present?
        @resources= resource.joins(:roles, :specialities).where(user_roles: {role_id: params[:role_id]}).where(specialities_users: {speciality_id: params[:speciality_id]})
      elsif params[:role_id].present?
        @resources= resource.joins(:roles).where(user_roles: {role_id: params[:role_id]})
      elsif params[:speciality_id].present?
        @resources= resource.joins(:specialities).where(specialities_users: {speciality_id: params[:speciality_id]})
      end
    # end
  end

  def update
    process_attachments # We only process attachment, other parameter can save automatically.
    super do |resource|
    	if current_user.has_role?("salesman_before_sale") || current_user.has_role?("salesman")
		    pa = current_user.salesmans_postal_codes.all.pluck(:postal_code)
		    @del_customers = Role.delegated_customer.first.users.where(postal_code: pa)
		  elsif @resource.establishment.present?
	  		@del_customers = Role.delegated_customer.first.users.where(id: @resource.establishment.users.ids)
		  elsif @resource.country.present?
        @del_customers = Role.delegated_customer.first.users.where(country: @resource.country)
		  else
		  	@del_customers = Role.delegated_customer.first.users
		  end
      @postal_code = SalesmansPostalCode.where(user_id: @resource.id).pluck(:postal_code)
      unless resource.errors.any?
        @resource.salesmans_postal_codes.destroy_all
        create_postal
      	if( params[:user][:role_ids] & Role.customer.ids.map(&:to_s) ).any?
      		@resource.customers.destroy_all
					delegate_customer_ids = params[:user][:del_customers_attributes].first[1].values.join(' ').split(' ')
					delegate_customer_ids.each do |id|
						DelCustomer.create({customer_id: @resource.id, delegate_customer_id: id})
					end
				end
        if UserTempDetail.exists?(user_id: @resource.id)
          user_temp_data = UserTempDetail.find_by(user_id: @resource.id)
          user_temp_data.destroy
        end
      else
        @temp_data = @resource.user_temp_detail
        @temp_skill_details = @temp_data&.temp_skill_details || TempSkillDetail.none
      end

			@bank_account = BankAccount.where(:user_id => resource.id)
			if params[:user][:bank_accounts_attributes]
				if @bank_account != []
					@bank_account.update(:iban => params[:user][:bank_accounts_attributes]["0"][:iban], :bic => params[:user][:bank_accounts_attributes]["0"][:bic])
				else
					BankAccount.create(:iban => params[:user][:bank_accounts_attributes]["0"][:iban], :bic => params[:user][:bank_accounts_attributes]["0"][:bic], :user_id => resource.id )
				end
			end

		end
    @url = request.original_url + "/edit"
    @message = @resource.email + " has updated profile"
    # @notification = Notification.new(message: @message, user_id: @resource.id, title: "User profile updated", url: @url, active: "true")
    # @notification.save
  # end
	end

	def accounts_to_active
		@resources = User.where.not(status: "Active")
	end

	def active_account_form
	end

	def update_account_status
		@resource.update_attributes(active_account_params)
		redirect_to accounts_to_active_admin_users_path
	end

	def pending_accounts
		@resources = User.Pending
	end

	def active_accounts
		@resources = User.Active
	end

	def deactive_accounts
		@resources = User.Deactive
	end

	def add_salesman_id
		User.where(email: params["user"]["email"]).update(salesman_id: current_user.id)
	end

	def checkpostalcode
		@code = SalesmansPostalCode.find_by(postal_code: params[:tag])
		render json: @code
	end

  def approved_data
  end

	def get_del_cust_by_country
		@del_customers = Role.delegated_customer.first.users.where(country: params[:country_id])
		render json: @del_customers
	end

  def show_signature
    @resource = User.find(params[:id])
    respond_to :js
  end

  def delete_signature
    @resource = User.find(params[:id])
    @id = @resource.id
    @resource.signature = nil
    @resource.save
    @resource.signature.destroy
    @resource.signature.clear
    respond_to :js
  end

  def set_current_role
    session[:current_role_id] = params[:value] if params[:value]
    render :json => {status: :ok}
  end

	private

	def permitted_attributes
    ["email", "password", "password_confirmation", "title", "first_name", "last_name", "photo", "signature", "establishment_id", "establishment_service_id", "emp_status", "gender", "birth_date", "address", "street", "city", "country", "postal_code", "phone", "status", speciality_ids: [], position_ids: [], insurance_ids: [], role_ids: [],
     user_skills_attributes: [:id, :skill_id, :proof, :temp_id, :comment, :_destroy, :updated_at], insurances_attributes: [:id, :name, :end_date, :_destroy, insurance_files_attributes: [:id, :insurance_id, :ins_file, :temp_id, :_destroy, :updated_at]]]
	end

	def create_postal
		return false unless params.dig("user","salesmans_postal_codes_attributes","0","postal_code").present?
		postal_code_data = []
		postal_codes  = params["user"]["salesmans_postal_codes_attributes"].first[1].first.second.split(',')
		postal_codes.each do |data|
		 	postal_code_data.push({user_id:@resource.id,postal_code:data})
		end
		SalesmansPostalCode.create(postal_code_data)
	end

  def check_status
    unless has_permission(controller_path,"active_user_account")
      if (has_permission(controller_path,"create") && has_permission(controller_path,"pre_creation_user"))
        if(params[:user][:status] != "Active")
          flash[:alert] = "You dont have permission to change the status."
          redirect_to root_path and return false
        end
      elsif (has_permission(controller_path,"pre_creation_user") && !has_permission(controller_path,"create") && params[:user][:status] != "Pending")
        flash[:alert] = "You dont have permission to change the status."
        redirect_to root_path and return false
      elsif (has_permission(controller_path,"create") && params[:user][:status] != "Active")
        flash[:alert] = "You dont have permission to change the status."
        redirect_to root_path and return false
      end
    end
  end

	def get_account
		@resource ||= User.find(params[:id])
	end

	def active_account_params
		params.require(:user).permit(:status)
	end

  # To redirect on appropriate index page for same resource like approved user list, pending user list and more
  def set_redirect_path
    session[:redirect_back] = { controller: controller_name, action: action_name }
  end

  def process_attachments
    # Assign temp_data model id to temp variable and set after initialize and before update callback
    # No need to set logic for destroy because we are simply remove record and no need to process attachment.
    process_skill_attachment
    process_insurance_attachment
  end

  def process_skill_attachment
    params[:user][:user_skills_attributes]&.each do |index, user_skill|
      if user_skill[:proof].present? && user_skill[:id].present? && !user_skill[:_destroy].present?
        # Update skill record
        # Set attachment from temp variable to proof field in 'before_update' callback
        if user_skill[:proof].is_a?(String)
          params[:user][:user_skills_attributes][index][:temp_id] = params[:user][:user_skills_attributes][index][:proof]
          params[:user][:user_skills_attributes][index][:proof] = ""
          params[:user][:user_skills_attributes][index][:updated_at] = Time.now # Change time so that model can detect change in record and call update callback of model
        end
      else
        # New skill record
        # Set attachment from temp variable to proof field in 'after_initialize' callback
        if user_skill[:proof].is_a?(String)
          params[:user][:user_skills_attributes][index][:temp_id] = params[:user][:user_skills_attributes][index][:proof]
          params[:user][:user_skills_attributes][index][:proof] = ""
        end
      end
    end
  end

  def process_insurance_attachment
    params[:user][:insurances_attributes]&.each do |ins_index, insurance|
      if !insurance[:_destroy].present?
        insurance[:insurance_files_attributes]&.each do |ins_file_index, insurance_file|
          # Update Insurance record
          # Set attachment from temp variable to ins_file field in 'before_update' callback
          if insurance_file[:ins_file].present? && insurance_file[:id].present? && !insurance_file[:_destroy].present?
            if insurance_file[:ins_file].is_a?(String)
              params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:temp_id] = params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:ins_file]
              params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:ins_file] = ""
              params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:updated_at] = Time.now # Change time so that model can detect change in record and call update callback of model
            end
          else
            # New insurance record
            # Set attachment from temp variable to ins_file field in 'after_initialize' callback
            if !insurance_file[:_destroy].present?
              if insurance_file[:ins_file].is_a?(String)
                params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:temp_id] = params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:ins_file]
                params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:ins_file] = ""
                params[:user][:insurances_attributes][ins_index][:insurance_files_attributes][ins_file_index][:updated_at] = Time.now # Change time so that model can detect change in record and call update callback of model
              end
            end
          end
        end
      end
    end
  end

end
