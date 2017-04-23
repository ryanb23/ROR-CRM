class Admin::RolesController < Admin::BaseController
	include Authorizations
	before_action :prevent_access, except: [:create, :update]
	
	private

	def configure_redirect_path
		redirect_to admin_permissions_path
	end
	
	def permitted_attributes
		["name_en", "name_fr", "protected", "custom_role_id", permission_ids: []]
	end

	def prevent_access
		raise ActionController::RoutingError.new('Not Found')
	end

end
