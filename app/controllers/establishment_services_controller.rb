class EstablishmentServicesController < ApplicationController
	# inherit_resources
	def index
		return false unless params[:id].present?
		establishment = Establishment.find(params[:id])
		@establishment_service = establishment.establishment_services
		@delegated_customers = Role.delegated_customer.first.users.where(id: establishment.users.ids)
		# render json: @establishment_service
		respond_to do |format|
			format.json  { render :json => {:establishment_service => @establishment_service,
                                  :delegated_customers => @delegated_customers }}
      # format.json  { render :json => @establishment_service.to_json(:include => [:material_costs])}
    end
	end
end
