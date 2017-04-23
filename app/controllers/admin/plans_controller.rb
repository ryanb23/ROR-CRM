class Admin::PlansController < Admin::BaseController
	include Authorizations

	def create
		params["plan"]["created_by"] = current_user.id
		super
	end

end
