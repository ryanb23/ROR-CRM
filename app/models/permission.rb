class Permission < ApplicationRecord
	has_many :role_permissions
	has_many :roles, through: :role_permissions, dependent: :destroy
	validates :name_en, presence: true
	accepts_nested_attributes_for :role_permissions, allow_destroy: true

	scope :include_permission, -> { where "subject_class NOT IN (?)",EXPECT_CONTROLLER }

	def find_role(custom_role_id)
		return self.role_permissions.find_by(role_id: custom_role_id).present?
	end

	def name_with_local
		I18n.locale == 'en' ? name_en : name_fr
	end
end
