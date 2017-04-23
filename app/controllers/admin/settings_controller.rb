class Admin::SettingsController < Admin::BaseController
	before_action :check_permission,only: [:index,:update_settings]
	def index
		@resources = Setting.all
	end
	def update_settings
		@setting = Setting.find_by(id: params[:id])
		if params[:setting][:price]
			@setting.update_attributes(price: params[:setting][:price])
		else
			@setting.update_attributes(workflow_type: params[:setting][:workflow_type],payment_type: params[:setting][:payment_type],billing_price: params[:setting][:billing_price],technical_provider_price: params[:setting][:technical_provider_price],payment_waiting_delay: params[:setting][:payment_waiting_delay],technical_provider_delay: params[:setting][:technical_provider_delay],analysis_delay: params[:setting][:analysis_delay],workflow_delay: params[:setting][:workflow_delay])
		end
		@resources = Setting.all
		redirect_to admin_settings_path
	end
	private
		def check_permission
			unless current_user.has_role?("root")
				flash[:alert] = "Access denied. You are not authorized to access the requested page."
	      redirect_to root_path
			end
		end
end
