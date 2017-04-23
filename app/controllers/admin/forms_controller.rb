class Admin::FormsController < Admin::BaseController
	include Authorizations

	def index
		@forms = Form.all
		@patient_draft_data = PatientDraftDatum.all
		@all_items = [@forms,@patient_draft_data].flatten.sort_by{ |data|  data.updated_at}
		@all_form_data = @all_items.reverse
	end
	private

	def get_resource
		@resource ||= Form.find(params[:id])
		redirect_to root_path, :alert => "You can't view the form if it's status is draft" if @resource.draft?
	end

  def permitted_attributes
    ["form_type", "name", "iban", "bic", "address", "postal_code", "city", "country"]
  end
end
