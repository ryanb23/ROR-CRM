class Equipment < ApplicationRecord
  belongs_to :equipment_model
  belongs_to :user
  validates :serial_number,:acquisition_date,:start_date,:end_date,:incident,:leasing_reference,:status,:equipment_model_id,:salesman_id, presence: true
  validate :check_end_date, if: :end_date?

  delegate :name,:to => :equipment_model, :prefix => true
  delegate :first_name,:last_name,:to => :user, :prefix => true

  def self.equipment_field
  	["serial_number","incident","leasing_reference","status"]
  end

  def check_end_date
    errors.add(:end_date, "must be grater then start date") if end_date < start_date
  end
end
