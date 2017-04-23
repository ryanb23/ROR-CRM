class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
		NotificationService::Notify.call(notification)
  end
end
