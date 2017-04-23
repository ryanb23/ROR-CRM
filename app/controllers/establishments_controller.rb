class EstablishmentsController < ApplicationController
	# inherit_resources
	def index
		@establishments = Establishment.all
		render json: @establishments
	end
end
