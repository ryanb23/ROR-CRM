class EquipmentModel < ApplicationRecord
	include Filterable
  belongs_to :equipment_brand
  has_many :equipments, dependent: :destroy
  validates :name,:equipment_brand_id ,presence: true

	belongs_to :equipment_type
	delegate :name,:to => :equipment_type, :prefix => true
end
