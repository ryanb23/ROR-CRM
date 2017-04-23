class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(notify_model, opts={})
    NotificationService::Notification.new(notify_model, opts).process
    	.on_success{ |notification|
    		NotificationRelayJob.perform_later(notification)
    	}
  end
end
