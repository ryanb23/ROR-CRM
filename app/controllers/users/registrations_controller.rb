class Users::RegistrationsController < Devise::RegistrationsController
  before_action :user_temp_data, :only => [:update]
  include Authorizations
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # load_and_authorize_resource
  # before_filter :load_permissions
  before_action :check_role, only: [:create]
  # before_action :check_role_for_update, only: [:update]


  # GET /resource/sign_up
  def new
    @role = Role.find_by(id: session[:role]&.dig("id"))
    return redirect_to role_selection_index_path unless @role.present?
    @del_customers = Role.delegated_customer.first.users
    super
  end

  # POST /resource
  def create
    @role = Role.find_by(id: session[:role]&.dig("id"))
    @del_customers = Role.delegated_customer.first.users
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

    if resource.persisted?
      CreateNotificationJob.perform_later(resource, title: t('notification.user.create.title'), description: t('notification.user.create.description'), action: action_name, redirect_url: pending_accounts_admin_users_url, user: resource)
      resource.update_attributes(password_changed_at: Time.now)
      if params[:bank_account].present?
        resource.bank_accounts.create(iban: params[:bank_account][:iban], bic: params[:bank_account][:bic])
      end
      if( params[:user][:role_ids] & Role.customer.ids.map(&:to_s) ).any?
        delegate_customer_ids = params[:user][:del_customers_attributes].first[1].values.join(' ').split(' ')
        delegate_customer_ids.each do |id|
          DelCustomer.create({customer_id: resource.id, delegate_customer_id: id})
        end
      end
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        # exit
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: new_user_registration_url
      end
      session.delete(:role)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

    # super

    # @user = User.find_by(email: params[:user][:email])
    # if @user
    #   @user.update_attributes(password_changed_at: Time.now)
    #   if params[:bank_account].present?
    #     @user.bank_accounts.create(iban: params[:bank_account][:iban],bic: params[:bank_account][:bic])
    #   end
    #   # if resource.persisted?
    #   #   if resource.active_for_authentication?
    #   #     set_flash_message! :notice, :signed_up
    #   #     sign_up(resource_name, resource)
    #   #     respond_with resource, location: after_sign_up_path_for(resource)
    #   #   else
    #   #     set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
    #   #     expire_data_after_sign_in!
    #   #     respond_with resource, location: after_inactive_sign_up_path_for(resource)
    #   #   end
    #   # end
    #  end
  end

  # GET /resource/edit
  def edit
    @postal_code = SalesmansPostalCode.where(user_id: resource.id).pluck(:postal_code)

    if current_user.has_role?("salesman_before_sale") || current_user.has_role?("salesman")
      pa = current_user.salesmans_postal_codes.all.pluck(:postal_code)
      @del_customers = Role.delegated_customer.first.users.where(postal_code: pa)
    elsif resource.establishment.present?
        @del_customers = Role.delegated_customer.first.users.where(id: resource.establishment.users.ids)
    elsif resource.country.present?
      @del_customers = Role.delegated_customer.first.users.where(country: resource.country)
    else
      @del_customers = Role.delegated_customer.first.users
    end
    super
  end

  # PUT /resource
  def update
    super do |resource|
      if current_user.has_role?("salesman_before_sale") || current_user.has_role?("salesman")
        pa = current_user.salesmans_postal_codes.all.pluck(:postal_code)
        @del_customers = Role.delegated_customer.first.users.where(postal_code: pa)
      elsif resource.establishment.present?
        @del_customers = Role.delegated_customer.first.users.where(id: resource.establishment.users.ids)
      elsif resource.country.present?
        @del_customers = Role.delegated_customer.first.users.where(country: resource.country)
      else
        @del_customers = Role.delegated_customer.first.users
      end
      @postal_code = SalesmansPostalCode.where(user_id: resource.id).pluck(:postal_code)
      unless resource.errors.any?
        CreateNotificationJob.perform_later(resource, title: t('notification.user.update.title'), description: t('notification.user.update.description', identity: resource.identity), action: action_name, redirect_url: edit_admin_user_url(resource), user: current_user)
        resource.salesmans_postal_codes.destroy_all
        create_postal
        if( params[:user][:role_ids] & Role.customer.ids.map(&:to_s) ).any?
          resource.customers.destroy_all
          delegate_customer_ids = params[:user][:del_customers_attributes].first[1].values.join(' ').split(' ')
          delegate_customer_ids.each do |id|
            DelCustomer.create({customer_id: resource.id, delegate_customer_id: id})
          end
        end
      end

      @bank_account = BankAccount.where(:user_id => current_user.id)
      if params[:user][:bank_accounts_attributes]
        if @bank_account != []
          @bank_account.update(:iban => params[:user][:bank_accounts_attributes]["0"][:iban], :bic => params[:user][:bank_accounts_attributes]["0"][:bic])
        else
          BankAccount.create(:iban => params[:user][:bank_accounts_attributes]["0"][:iban], :bic => params[:user][:bank_accounts_attributes]["0"][:bic], :user_id => current_user.id )
        end
      end
    end
    # @url = request.original_url + "/edit"
    # @message = "profile of " + params["user"]["email"] + " has updated"
    # @notification = Notification.new(message: @message, user_id: current_user.id, title: "User profile updated", url: @url, active: "true")
    # @notification.save
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   redirect_to :root
  #   # signed_in_root_path(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def create_postal
    return false unless params.dig("user", "salesmans_postal_codes_attributes", "0", "postal_code").present?
    postal_code_data = []
    postal_codes = params["user"]["salesmans_postal_codes_attributes"].first[1].first.second.split(',')
    postal_codes.each do |data|
      postal_code_data.push({user_id: resource.id, postal_code: data})
    end
    SalesmansPostalCode.create(postal_code_data)
  end

  def account_update_params
    # devise_parameter_sanitizer.sanitize(:account_update) do
    params.require(:user).permit(["email", "password", "password_confirmation", "title", "first_name", "last_name", "photo", "signature", "establishment_id", "establishment_service_id", "emp_status", "gender", "birth_date", "address", "street", "city", "country", "postal_code", "phone", "status", speciality_ids: [], position_ids: [], insurance_ids: [], role_ids: [],
                                  user_skills_attributes: [:id, :skill_id, :proof, :comment, :_destroy], bank_accounts_attributes: [:id, :iban, :bic, :_destroy], insurances_attributes: [:id, :name, :end_date, :_destroy, insurance_files_attributes: [:id, :insurance_id, :ins_file, :_destroy]]])
  end

  def update_resource(resource, params)
    resource.update_without_password(params.except(:del_customers_attributes, :bank_accounts_attributes))
  end

  private

  def user_temp_data
    flag = true
    if current_user.has_role?("root")
      flag = false
    end
    if flag
      # exit
      create_user_temp_detail
      # flash[:notice] = "Need to validate updated data."
      resource_params = params[:user].except!(:establishment_id, :establishment_service_id, :speciality_ids, :user_skills_attributes, :insurances_attributes, :title)
      update_resource(resource, resource_params)
    else
      update_resource(resource, account_update_params)
    end
  end

  def create_user_temp_detail
    if UserTempDetail.exists?(user_id: @user.id)
      user_temp_data = UserTempDetail.find_by(user_id: @user.id)
      user_temp_data.destroy
    end

    @user_temp_detail = UserTempDetail.create(user_temp_detail_params(params[:user]).merge(user_id: @user.id))

    create_skill_temp_details
    create_insurance_temp_details
  end

  def create_skill_temp_details
    if params[:user][:user_skills_attributes].present?
      # store skills data with file in temp_skill_details
      skill_updates_ids = []
      # Detect update field and send updated field record id array in form.
      skill_updates_ids = params[:skill_updates_ids].split(",").reject(&:blank?).uniq
      params[:user][:user_skills_attributes].each do |index, skill|
        # skill Id not present means New skill added
        # Destroy flag pass with value "1" means Removed existing skill
        # skill Id present means update skill
        if !skill[:id].present? || skill[:_destroy] == "1"
          # Save in temp table as add skill and remove skill status
          skill_resource = @user_temp_detail.temp_skill_details.create(skill_params(skill).merge(user_skill_id: skill[:id]))
          if !skill[:id].present?
            skill_resource.added!
          elsif skill[:_destroy] == "1" && skill[:id].present?
            skill_resource.removed!
          end
        else
          # Save in temp table as update skill status
          if skill_updates_ids.include?(skill[:id])
            skill_resource = @user_temp_detail.temp_skill_details.create(skill_params(skill).merge(user_skill_id: skill[:id]))
            skill_resource.change!
          end
        end
      end
    end
  end

  def create_insurance_temp_details
    if params[:user][:insurances_attributes].present?
      # Store insurance details in temp_insurance_detail
      # store insurance files in temp_insurance_files with temp_insurance_detail_id
      # Detect update insurance field and send updated insurance field record id array in form.
      insurance_updates_ids = params[:insurance_updates_ids].split(",").reject(&:blank?).uniq
      # Detect update insurance file field and send updated insurance file field record id array in form.
      insurance_file_updates_ids = params[:insurance_file_updates_ids].split(",").reject(&:blank?).uniq
      params[:user][:insurances_attributes].each do |ins_index, temp_insurance|
        # Map params key with actuall insurance table field.Currently it is different in both table insurance and temp_insurance_detail
        temp_insurance = map_temp_insurance_attributes_with_insurance(temp_insurance)
        if !temp_insurance[:id].present?
          # Save as new insurance added by user with added status
          insurance_resource = @user_temp_detail.temp_insurance_details.create(insurance_params(temp_insurance))
          insurance_resource.added!
        elsif temp_insurance[:_destroy] == "1" && temp_insurance[:id].present?
          # Save as existing insurance removed by user with removed status
          insurance_resource = @user_temp_detail.temp_insurance_details.create(insurance_params_without_file(temp_insurance).merge(insurance_id: temp_insurance[:id]))
            insurance_resource.removed!
        else
          # Save as existing insurance updated by user with change status
          if insurance_updates_ids.include?(temp_insurance[:id])
            insurance_resource = @user_temp_detail.temp_insurance_details.create(insurance_params_without_file(temp_insurance).merge(insurance_id: temp_insurance[:id]))
            insurance_resource.change!
            # Update insurance file if any
            create_insurance_file_temp_details(temp_insurance, insurance_resource, insurance_file_updates_ids)
          end
        end
      end
    end
  end

  def create_insurance_file_temp_details(temp_insurance, insurance_resource, insurance_file_updates_ids)
    temp_insurance[:temp_insurance_files_attributes].each do |ins_file_index, temp_insurance_file|
      if insurance_file_updates_ids.include?(temp_insurance_file[:id])
        if temp_insurance_file[:_destroy].present?
          # Save as existing insurance file removed by user with removed status
          temp_insurance_file[:temp_id] = temp_insurance_file[:id]
          insurance_file_resource = insurance_resource.temp_insurance_files.create(insurance_file_params(temp_insurance_file).merge(insurance_file_id: temp_insurance_file[:id]))
          insurance_file_resource.removed!
        else
          # Save as existing insurance file updated by user with change status
          insurance_file_resource = insurance_resource.temp_insurance_files.create(insurance_file_params(temp_insurance_file).merge(insurance_file_id: temp_insurance_file[:id]))
          insurance_file_resource.change!
        end
      elsif temp_insurance_file[:ins_file] && !temp_insurance_file[:id].present?
        # Save as existing insurance file added by user with added status
        insurance_file_resource = insurance_resource.temp_insurance_files.create(insurance_file_params(temp_insurance_file))
          insurance_file_resource.added!
      end
    end
  end

  def user_temp_detail_params(user_temp_detail_param)
    user_temp_detail_param.permit(user_temp_detail_permitted_attributes)
  end

  def user_temp_detail_permitted_attributes
    # :establishment_id, :establishment_service_id, speciality_ids: []
    permitted = (params[:user_updates_ids].split(",") & ["establishment_id", "establishment_service_id"])
    permitted = [speciality_ids: []].concat(permitted) if params[:user_updates_ids].split(",").include?("speciality_ids")
    permitted
  end

  def skill_params(skill)
    skill.permit(:skill_id, :comment, :proof, :user_skill_id)
  end

  def insurance_params(insurance)
    insurance.permit(:ins_name, :ins_end_date, :insurance_id, temp_insurance_files_attributes: [:ins_file, :_destroy])
  end

  def insurance_params_without_file(insurance)
    insurance.permit(:ins_name, :ins_end_date, :insurance_id)
  end

  def insurance_file_params(insurance_file)
    insurance_file.permit(:ins_file, :temp_id)
  end

  def map_temp_insurance_attributes_with_insurance(insurance)
    mappings = {"name" => "ins_name", "end_date" => "ins_end_date", "insurance_files_attributes" => "temp_insurance_files_attributes" }
    ActionController::Parameters.new(insurance.map {|k, v| [mappings[k] || k, v] }.to_h)
  end

  def check_role
   roles = ["customer","technical_service_provider"]
   existing_roles = Role.where(custom_role_id: roles)
   new_roles =  Role.where(id: params[:user][:role_ids])
   unless existing_roles.exists? (new_roles)
    redirect_to root_path, :alert => "You can't select any role except customer and provide role."
   end
    # params[:user][:role_ids].any? { |i| (["33","38"]).include?(i) }
  end

  # def check_role_for_update
  #   params[:user].except!(:role_ids) unless current_user.has_role?("root")
  #   if params[:user][:role_ids]
  #     if !current_user.roles.exists?(Role.first)
  #       redirect_to root_path, :alert => "You can't change role if your role is not root."
  #     end
  #   end
  # end
end
