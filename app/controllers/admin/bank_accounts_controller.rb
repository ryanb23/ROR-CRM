class Admin::BankAccountsController < Admin::BaseController
	include Authorizations
	def index
		@resources = resource_class.includes(:user).all.order('updated_at DESC')
	end
end
