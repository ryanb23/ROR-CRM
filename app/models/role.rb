class Role < ApplicationRecord
	validates :name_en,:name_fr, presence: true,uniqueness: true
  # validates :permissions, presence: true
	has_many :role_permissions
	has_many :permissions, through: :role_permissions, dependent: :destroy
	has_many :user_roles
  has_many :users, through: :user_roles,dependent: :destroy

	enum custom_role_id: { :root => 0, :IT_admin => 1, :manager => 2, :internal_physician_supervisor => 3,:customer => 4,:delegated_customer => 5,:establishment_admin => 6,:service_admin => 7,:physician => 8,:technical_service_provider => 9,:admin_staff => 10,:salesman_before_sale => 11,:salesman => 12,:patient => 13 }

	scope :protected_roles, -> { where(protected: 1) }
	SALESMAN_ROLE = ["salesman_before_sale"]
	scope :salesman_roles, -> { where("custom_role_id = ?",SALESMAN_ROLE) }
	
  def name_with_local
    I18n.locale == 'en' ? name_en : name_fr
  end

  def self.role_access
  	roles = ["Root" ,"IT Administrator", "Manager", "Internal Physician Supervisor"]
  	@check_roles = self.where("name_en not IN (?)",roles)
  	return @check_roles
  end
end
