class Subscription < ApplicationRecord
  belongs_to :plan
  belongs_to :entity, polymorphic: true
  has_many :invoices
end
