class EquipmentType < ApplicationRecord
	has_many :equipment_brands, dependent: :destroy
	has_many :equipments, dependent: :destroy

	validates :name, uniqueness: true, presence: true
end
