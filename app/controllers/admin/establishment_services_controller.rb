class Admin::EstablishmentServicesController < Admin::BaseController
	# load_and_authorize_resource
	# before_filter :load_permissions
	include Authorizations
	def index
		if params[:id].present?
			@establishment = Establishment.find(params[:id])
			@establishment_services = @establishment.establishment_services
		else
			@resources = EstablishmentService.all.order('updated_at DESC')
		end
		respond_to do |format|
			format.html
			format.json { render json: @establishment_services }
		end
	end
end
