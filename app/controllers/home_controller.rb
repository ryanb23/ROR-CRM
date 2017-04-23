class HomeController < ApplicationController
	before_action :authenticate_user!
	# before_filter :load_and_authorize_resource
	# authorize_resource class: false
	# before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error

	def index
	end

end