class TempInsuranceDetail < ApplicationRecord
  belongs_to :insurance
  belongs_to :user_temp_detail
  has_many :temp_insurance_files, dependent: :destroy
  enum operation_status: { :added => 0, :change => 1, :removed => 2 }

  accepts_nested_attributes_for :temp_insurance_files, allow_destroy: true

  scope :change_and_removed, -> { where(operation_status: [:change, :removed]) }
  scope :filter_by_association, -> (insurance_id) { where(insurance_id: insurance_id ) }
end
