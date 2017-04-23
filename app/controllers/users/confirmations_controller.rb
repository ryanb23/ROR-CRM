class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  #   @user = User.find_by(confirmation_token: params[:confirmation_token])
  #   @user.update_attributes(status: 1)
  #   # puts "=========================#{@user.inspect}============================="
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    # exit
    # @user = User.find_by(confirmation_token: params[:confirmation_token])
    resource.update_attributes(status: "Confirmation_pending")
    signed_in_root_path(resource)
  end
end
