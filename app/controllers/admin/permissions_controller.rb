class Admin::PermissionsController <  Admin::BaseController
	include ApplicationHelper
	before_action :check_permission,only: [:index,:edit,:update]
	before_action :check_role, only: [:update]
  after_action :set_redirect_path, only: [:new, :edit]

	def resource_class
		Role
	end

	# def configure_redirect_path
	# 	redirect_to admin_permissions_path
	# end

	def resource_name
		"role"
	end

	private

	def permitted_attributes
		["name_en", "name_fr", "protected", "custom_role_id", permission_ids: []]
	end

	def check_role
		if @resource.protected == 1 &&  params[:role][:name_fr]
			unless @resource.name_fr == params[:name_fr]
				redirect_to root_path, :alert => "You can't change role name in french"
			end
		end
	end

	def check_permission
		unless has_permission("admin/roles","create") || has_permission("admin/roles","update")
		# unless current_user.has_role?("root")
			flash[:alert] = "Access denied. You are not authorized to access the requested page."
      redirect_to root_path
		end
	end

	def set_redirect_path
    session[:redirect_back] = { controller: controller_name, action: "index" }
  end
end
