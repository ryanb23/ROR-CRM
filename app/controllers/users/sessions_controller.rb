class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  prepend_before_action :allow_params_authentication!, only: :create
  # GET /resource/sign_in
  # def new
  #   # logger.info "=====================in new==================="
  #   super
  # end

  # POST /resource/sign_in
  def create
    # Create user on Authy, will return an id on the object
    user_email = User.all.pluck(:email)
    @user = User.find_by_email(params[:user][:email])
    if @user && params[:user][:password].present?
      user_time = @user.password_changed_at
      if @user.password_changed_at.present?
        time_diff = ((Time.now - user_time)/1.day).to_i
        if time_diff > 7
          # password_token = @user.send_reset_password_instructions
          PasswordExpiredMailer.password_change(@user.id).deliver
          reset_session
          flash.alert = "Your Password is expired. Please activate it from mail!"
          redirect_to new_user_session_path
        else
          if !@user.valid_password?(params[:user][:password])
            flash[:error] = "Please enter valid password"
            render 'new'
          elsif @user.has_role?("root")
            # redirect_to admin_dashboard_path
            redirect_to root_path
          else
            redirect_to root_path
          end
        end
      else
         if @user.has_role?("root")
            # redirect_to admin_dashboard_path
            redirect_to root_path
          else
            redirect_to root_path
          end
      # end
        # session[:current_url]
        # exit
      end
    elsif params[:user][:email].present? && !user_email.include?(params[:user][:email]) && !params[:user][:password].present?
        flash.clear
        flash[:error] = "Please enter valid email"
        render 'new'
    elsif params[:user][:email].present? && user_email.include?(params[:user][:email])
      flash.clear
      flash[:error] = "Please enter valid password"
      render 'new'
    else
      flash.clear
      flash[:error] = "Please enter valid email and password"
      render 'new'
    end
    # @user = User.authy(@user)
    # # render :verify_authy_installation
    # redirect_to user_verify_authy_installation_path
  end

  # def verify_authy_installation
  # end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
