class Admin::UserSkillsController < ApplicationController
  before_action :get_resource, only: [:show,:destroy]
	respond_to :js, only: [:show,:destroy]

	def destroy
		@id = @resource.id
		@resource.proof = nil
		@resource.save
		@resource.proof.destroy
		@resource.proof.clear
	end
  private

  def get_resource
  	@resource = UserSkill.find(params[:id])
  end
end
