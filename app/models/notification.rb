class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  has_many :notifications_recipients, dependent: :destroy
	has_many :recipients, through: :notifications_recipients, dependent: :destroy

	scope :unread, -> { where("is_read = false") }

	def read!
		update_attributes(is_read: true)
	end
end
