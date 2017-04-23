class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery prepend: true
  before_action :configure_addtional_fields,if: :devise_controller?
  before_action :set_locale,:set_notifications,:set_role
  @@set_lang = false

  def set_notifications
    # @notifications ||= Notification.where("active = ?", "true").order(created_at: :desc)
    # @role = Role.where("custom_role_id = ?", 0).first
    # @user_roles = UserRole.where("role_id = ?", @role.id)

    # @user_roles.each do |userRole|
    #   if current_user
    #     if current_user.id == userRole.user_id
    #       @notifications ||= Notification.where("active = ?", "true").order(created_at: :desc)
    #     end
    #   end
    # end

  end

  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied. You are not authorized to access the requested page."
    redirect_to root_path
  end

  protected

  def configure_addtional_fields
    added_attrs = [:email,:password,:phone,:signature,:country,:photo, :first_name,:last_name,:gender,:birth_date,:address,:street,:city,:postal_code,:title,:emp_status,:establishment_id,:establishment_service_id,speciality_ids: [],position_ids: [],role_ids: [],:insurances_attributes => [:id,:name,:end_date,:_destroy,insurance_files_attributes: [:id,:insurance_id,:ins_file,:_destroy]], :user_skills_attributes=>[:id,:skill_id,:proof,:comment]]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # def self.permission
  #   return name = self.name.gsub('Controller','').singularize.split('::').last rescue nil
  # end

  # def current_ability
  #   @current_ability ||= Ability.new(current_user)
  # end
  #load the permissions for the current user so that UI can be manipulated
  # def load_permissions
  #   # @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}

  #   # @current_permissions = current_user.roles.each do |role|
  #   #   role.permissions.collect{|i| [i.subject_class, i.action]}
  #   # end
  #   current_user.roles.each do |role|
  #    @current_permissions = role.permissions.collect{|i| [i.subject_class, i.action]}
  #   end
  # end

  def set_locale
    if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
      l = cookies[:educator_locale].to_sym
    else
      l = I18n.default_locale
      cookies[:educator_locale] = l
    end
    I18n.locale = l

    # if(@@set_lang == false)
    #   l = request.location.country
    #   if !l || l == "Reserved"
    #     l = I18n.default_locale
    #   end
    #   if l != :fr && l != :en
    #     l = I18n.default_locale
    #   end
    #   I18n.locale = l
    #   cookies[:educator_locale] = l
    #   @@set_lang = true
    # end
  end

  def set_role
    if current_user && current_user.roles 
      unless session[:current_role_id].present?
        session[:current_role_id] = current_user.roles.first.id
      end
    end
  end
end
