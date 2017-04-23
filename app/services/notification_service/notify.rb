require 'response/success'
require 'response/error'

module NotificationService
	class Notify
		include Base
		include ApplicationHelper

		def call(notification)
			# # get notification template to prepend in notification droplist
			# notification_template = render_notification_template(notification)
			# Broadcast notification
			notification.recipients.each do |recipient|
				ActionCable.server.broadcast "push_notifications:#{recipient.id}", {
					title: notification.title,
					description: notification.description,
					url: notification.redirect_url,
					icon_url: assets_path_helper.asset_path("missing.png"),
					notification_template: render_notification_template(recipient),
					notification_count: unread_notification_count(recipient)
				}
			end
		end

		private

	  def assets_path_helper
	  	ActionController::Base.helpers
	  end

	  def render_notification_template(recipient)
	  	ApplicationController.render(partial: "/layouts/shared/notification", collection: get_current_user_notifications(recipient) )
	  end

	end
end