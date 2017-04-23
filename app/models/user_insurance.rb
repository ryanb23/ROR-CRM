class UserInsurance < ApplicationRecord
  belongs_to :user
  belongs_to :insurance
  delegate :name, :id,:end_date, :insuances_file, to: :insurance ,:prefix =>true
end
