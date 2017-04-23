class InvoicesPatient < ApplicationRecord
  include Filterable
  belongs_to :form
  belongs_to :patient
  enum status: {"Pending" => 1, "Paid" => 2, "Cancel" => 3}
end
