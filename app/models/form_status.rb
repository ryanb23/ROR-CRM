class FormStatus < ApplicationRecord
  belongs_to :customer, :class_name => 'User'
  belongs_to :provider, :class_name => 'User'
  belongs_to :supervisor, :class_name => 'User'
  belongs_to :tech_provider, :class_name => 'User'
  belongs_to :patient
  belongs_to :form
  enum status: {"draft" => 1,"validated" => 2, "payment_pending" => 3, "provider_pending" => 4, "analysis_in_progress" => 5, "completed" => 6 , "canceled" => 7 }
end
