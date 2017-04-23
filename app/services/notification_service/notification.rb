require 'response/success'
require 'response/error'

module NotificationService
	class Notification

		def initialize(model, opts={})
			@opts = opts
			@model = model
			@title = opts[:title] || title
			@description = opts[:description] || description
			@redirect_url = opts[:redirect_url] || redirect_url
			@action = opts[:action]
			@user_id = opts[:user]&.id
			@notifiable = model
			@recipients_id = opts[:recipients]
		end

		def process
			notification = ::Notification.new(
				title: @title,
				description: @description,
				redirect_url: @redirect_url,
				action: @action,
				user_id: @user_id,
				notifiable: @notifiable
			)

			if notification.save!
				notification.recipients << (User.where(id: @recipients_id).presence || default_recipients)
				Success.new(notification, I18n.t("notification.created"))
			else
				Error.new(notification, I18n.t("notification.create.error"))
			end
		end

		private

		def title
			"#{@opts[:user].identity} react something."
		end

		def description
			"Action: #{@opts[:action]}, on: #{@model.class}" 
		end

		def redirect_url
			"/"
		end

		def default_recipients
			Role.root.first.users
		end

	end
end