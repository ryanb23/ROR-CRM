class SettingsController < ApplicationController
  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies[:educator_locale] = l

    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
    end
  end

  def set_role_before_sign_up
    @role = Role.find_by(id: params[:role])
    session[:role] = @role
    redirect_to sign_up_path
  end

  def get_users
    render json: {
      customer: Role.customer.ids[0],
      patient: Role.patient.ids[0],
      provider: Role.technical_service_provider.ids[0],
      physician: Role.physician.ids[0],
      delegate_customer: Role.delegated_customer.ids[0],
      salesman_before_sale: Role.salesman_before_sale.ids[0],
      salesman_sav: Role.salesman.ids[0]
    }
  end

  def find_customer_id
    @customer = Role.customer
    @customer_id = @customer.ids
    render :json => @customer_id
  end

  def find_patient_id
    @patient = Role.patient
    @patient_id = @patient.ids
    render :json => @patient_id
  end

  def find_provider_id
    @provider = Role.technical_service_provider
    @provider_id = @provider.ids
    render :json => @provider_id
  end

  def find_delegate_customer_id
    @delegate_customer = Role.delegated_customer
    @delegate_customer = @delegate_customer.ids
    render :json => @delegate_customer
  end

  def find_salesman_before_sale_id
    @salesman_before_sale = Role.salesman_before_sale
    @salesman_before_sale_id = @salesman_before_sale.ids
    render :json => @salesman_before_sale_id
  end

  def find_salesman_sav_id
    @salesman_sav = Role.salesman
    @salesman_sav_id = @salesman_sav.ids
    render :json => @salesman_sav_id
  end

  def find_physician_id
    @physician = Role.physician
    @physician_id = @physician.ids
    render :json => @physician_id
  end

  def get_all_skills
    @skill = Skill.all
    language = I18n.locale.to_s
    json_data = { skills: @skill, language: language }
    render :json => json_data
    # render :json => @skill
  end

  def establishment_form_check_postal_code
    if SalesmansPostalCode.where(:postal_code => params[:postal_code]).blank?
      render :json => "false"
    else
      render :json => "true"
    end
    # render :json => params[:postal_code]
  end

  def new_user_form_check_postal_code
    puts params.inspect

    if User.where(:postal_code => params["postal_code"]).blank?
      render :json => "false"
    else
      render :json => "true"
    end
  end

  def change_notification_value
    @notification = Notification.where(:url => params[:href])
    @notification.update(active: "false")
  end

  def mark_notification_as_read
    Notification.find(params[:notification_id]).read!
    head :ok # No need to render anything
  end

end
