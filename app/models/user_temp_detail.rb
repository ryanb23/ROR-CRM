class UserTempDetail < ApplicationRecord
  serialize :speciality_ids, Array

  belongs_to :user
  has_many :temp_insurance_details, dependent: :destroy
  has_many :temp_skill_details, dependent: :destroy
end
