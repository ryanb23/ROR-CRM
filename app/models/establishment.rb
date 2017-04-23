class Establishment < ApplicationRecord
	validates :bic,:iban,:name, :presence => true
	has_many :establishment_services, dependent: :destroy
	has_many :subscriptions , as: :entity,dependent: :destroy
	has_many :users,dependent: :destroy
	belongs_to :plan
end
