class RoleSelectionController < ApplicationController
	def index
		@customer_role = Role.customer[0]
		@provider_role = Role.technical_service_provider[0]
		@user = User.new
	end
end
