class Insurance < ApplicationRecord
	validates :end_date,:name,presence: true
	# validates :name,uniqueness: true
	has_many :insurance_files, dependent: :destroy
	has_many :user_insurances
	has_one :temp_insurance_detail
  has_many :users, through: :user_insurances,dependent: :destroy
  accepts_nested_attributes_for :insurance_files, allow_destroy: true
end
