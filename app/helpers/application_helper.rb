module ApplicationHelper
	def action_type(resource)
		resource.new_record? ? "Add" : "Edit"
	end

	def action_type_for_button(resource)
		result = resource.new_record? ? "Add" : "Update"
		if result == "Add"
			return t('activerecord.buttons.Add')
		else
			return t('activerecord.buttons.Update')
		end
	end

	def has_permission(permission_controller, permission_action)
		if current_user.present? && current_user.roles.present?
			role = Role.find(session[:current_role_id])
	    role.permissions.pluck(:subject_class,:action).include?([permission_controller.camelize, permission_action])
    else
      return false
    end
  end
		# def has_permission(permission_controller, permission_action)
		# 	if current_user.present? && current_user.roles.present?
		# 		current_user.roles.each do |role|
		# 			# role.permissions.each do |permission|
		# 				data = role.permissions.pluck(:subject_class,:action)
		# 				result =  data.detect{ |controller, action| controller == permission_controller.camelize && action == permission_action }
		# 				if result.present?
		# 					return true
		# 				end
		# 			# end
		# 		end
		# 		return false
		# 	else
		# 		return false
		# 	end
		# end

	# Create helper so that it is also used in service object
	def unread_notification_count(user = nil)
		Notification.from(get_current_user_notifications(user)).unread.size
	end

	def get_current_user_notifications(user = nil)
		user ||= current_user
		user.notifications.select(:id, :title, :description, :is_read, :redirect_url).where("notifications.id in (select max(id) as id from notifications group by redirect_url )").order(created_at: :desc).limit(5)
	end

	def current_role
		role = Role.find(session[:current_role_id]) if session[:current_role_id]
	end
end
