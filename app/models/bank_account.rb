class BankAccount < ApplicationRecord
  belongs_to :user
  validates :user_id,presence: true,if: :user_id?
  delegate :first_name,:last_name,:to => :user, :prefix => true
end
