class EquipmentBrand < ApplicationRecord
  belongs_to :equipment_type
  has_many :equipment_models,dependent: :destroy
  validates :name,:equipment_type_id , presence: true

  delegate :name,:to => :equipment_type, :prefix => true

end
