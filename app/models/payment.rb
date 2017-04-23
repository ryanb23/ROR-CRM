class Payment < ApplicationRecord
  serialize :payment_response
  enum status: { paid: 1, failed: 2 }
  belongs_to :form
end
