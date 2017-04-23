class Skill < ApplicationRecord
	has_many :user_skills
  has_many :users, through: :user_skills,dependent: :destroy
	validates :name_en, :name_fr, presence: true,uniqueness: true
	has_many :temp_skill_details

	def name
		case I18n.locale
		when :fr
			name_fr
		else
			name_en
		end
	end

end
