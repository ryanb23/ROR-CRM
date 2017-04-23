class Speciality < ApplicationRecord
	validates :name_en, :name_fr, presence: true,uniqueness: true
	has_and_belongs_to_many :users

	attr_accessor :name_with_description

	def  name_with_description
		if I18n.locale == :fr
			"#{name_fr} / #{description}"
		else
			"#{name_en} / #{description}"
		end
		# "#{name} / #{description}"
	end
end
