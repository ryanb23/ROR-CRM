# require 'active_support/concern'
module Admin::InheritAction
  extend ActiveSupport::Concern

	included do
  	before_action :get_resource, only: [:show, :edit, :update, :destroy]
  	# Remove redirect_back path if redirected or no actoin performed ( To redirect on appropriate index page for same resource like approved user list, pending user list and more)
  	before_action :remove_path_sessions, except: [:new, :create, :edit, :update, :destroy]
  	after_action :remove_path_sessions, only: [:create, :update, :destroy] if @resource && !@resource.errors.any?
	end

	# class_methods do
	# 	def block_inherit_action_except(*args)
	# 		action_methods - args.map(&:to_s)
	# 		# raise ActionController::RoutingError.new('Not Found') if action_name.exclude?(args)
	# 	end
	# end


	def index
		@resources = resource_class.all.order('updated_at DESC')
		respond_to do |format|
			format.html
			format.json { render json: @resources }
		end
	end

	def new
		@resource = resource_class.new(resource_params)
	end

	def pre_creation_user
		@resource = resource_class.new(resource_params)

	end

	def create

			@resource = resource_class.new(resource_params)

		if @resource.save
			yield @resource if block_given?
			configure_redirect_path
		else
			if current_user.has_role?("salesman_before_sale") || current_user.has_role?("salesman")
		    pa = current_user.salesmans_postal_codes.all.pluck(:postal_code)
		    @del_customers = Role.delegated_customer.first.users.where(postal_code: pa)
		  else
		  	@del_customers = Role.delegated_customer.first.users
		  end
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
    # exit
		if @resource.update_attributes(resource_params)
			yield @resource if block_given?
			configure_redirect_path
		else
			yield @resource if block_given?
			render 'edit'
		end
	end

	def destroy
		@resource.destroy
		configure_redirect_path
	end

	def search
		@resources = resource_class.filter(class_search_params)
		yield @resources if block_given?
		render 'index'
	end

	private

	def get_resource
		@resource ||= resource_class.find(params[:id])
	end

	def resource_class
		resource_name.classify.constantize
	end

	def resource_params
    params.fetch(resource_name, {}).permit(permitted_attributes)
	end

	def permitted_attributes
		resource_class.column_names
	end

	def configure_redirect_path
		redirect_to session[:redirect_back] || { controller: controller_name, action: :index }
	end

	def resource_name
		controller_name.singularize
	end

	def remove_path_sessions
		session.delete(:redirect_back) if session[:redirect_back].present?
	end

end
