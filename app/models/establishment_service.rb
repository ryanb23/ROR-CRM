class EstablishmentService < ApplicationRecord
  belongs_to :establishment
	validates :name,:establishment_id, presence: true
end
