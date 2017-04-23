class Plan < ApplicationRecord
	validates :name,:description,:quota,:price, :presence => true
	validates :price, numericality: { allow_nil: true }
	has_many :subscriptions,dependent: :destroy
	has_many :establishments
end
