class UserTempDatum < ApplicationRecord
  belongs_to :user
  # serialize :establishment_data
  serialize :skill_data, Hash
  serialize :insurance_data
  serialize :service_data
  serialize :speciality_data
end
