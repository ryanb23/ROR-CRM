class NotificationsRecipient < ApplicationRecord
  belongs_to :notification
	belongs_to :recipient, class_name: "User"
end
