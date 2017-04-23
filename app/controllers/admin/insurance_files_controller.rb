class Admin::InsuranceFilesController < ApplicationController
	before_action :get_resource, only: [:show,:destroy]
	respond_to :js, only: [:show,:destroy]

	def destroy
		@id = @resource.id
		@resource.destroy
	end
  private

  def get_resource
  	@resource = InsuranceFile.find(params[:id])
  end
end
