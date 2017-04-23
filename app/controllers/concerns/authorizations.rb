module Authorizations
  extend ActiveSupport::Concern

  included do
  	before_action :check_authorization
  end

	def check_authorization
		if current_user.present? && current_user.roles.present?
			# authorized = false
			# current_user.roles.each do |role|
			# 	role.permissions.each do |permission|
			# 		if controller_path.camelize == permission.subject_class
			# 			if (action_name == "new" || action_name == "create") && permission.action == "create"
			# 				 authorized = true
			# 			elsif (action_name == "edit" || action_name == "update") && permission.action == "update"
			# 				 authorized = true
			# 			elsif action_name == permission.action 
			# 				 authorized = true
			# 			elsif permission.subject_class == "Admin::Users"
			# 				if ( action_name == "pre_creation_user" || action_name == "create") && permission.action == "pre_creation_user"
			# 					 authorized = true
			# 				elsif ( action_name == "active_account_form" || action_name == "update_account_status") && permission.action == "active_user_account"
			# 					 authorized = true
			# 				end
			# 			end
			# 		end
			# 	end
			# end
			# redirect_to root_path, :alert => "Access denied. You are not authorized to access the requested page." if authorized == false
			redirect_to root_path, :alert => "Access denied. You are not authorized to access the requested page." unless authorized?
		end
	end

	def authorized?
		authorized = false
		role = Role.find(session[:current_role_id])
			role.permissions.each do |permission|
				if (controller_path == "admin/patients" || controller_path == "admin/forms" ||  controller_path == "admin/patient_draft_data") && (permission.subject_class == "Admin::Patients" ||  permission.subject_class == "Admin::Forms")
					if (action_name == "new" || action_name == "create") && permission.action == "create"
						return authorized = true
					elsif (action_name == "edit" || action_name == "update") && permission.action == "update"
						return authorized = true
					elsif action_name == permission.action 
						return authorized = true
					end
				elsif controller_path.camelize == permission.subject_class

					if (action_name == "new" || action_name == "create") && permission.action == "create"
						return authorized = true
					elsif (action_name == "edit" || action_name == "update") && permission.action == "update"
						if permission.subject_class == "Users::Registrations"
						 	if action_name == "update" && permission.action == "update"
								return authorized = true
							elsif action_name == "edit" && permission.action == "edit"
								return authorized = true
							end
						else
							return authorized = true
						end
					elsif action_name == permission.action 
						return authorized = true
					elsif permission.subject_class == "Admin::Users"
						if ( action_name == "pre_creation_user" || action_name == "create") && permission.action == "pre_creation_user"
							return authorized = true
						elsif ( action_name == "active_account_form" || action_name == "update_account_status") && permission.action == "active_user_account"
							return authorized = true
						end
					end
				end
			return authorized if authorized
			end
		return authorized
	end

end