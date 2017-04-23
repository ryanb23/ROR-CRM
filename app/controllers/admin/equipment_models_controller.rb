class Admin::EquipmentModelsController < Admin::BaseController
	include Authorizations
	def class_search_params
		params.slice(:equipment_brand_id, :name)
	end
end
