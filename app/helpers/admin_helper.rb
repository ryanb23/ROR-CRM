module AdminHelper
	def check_current_ctrl(con_name)
		"active" if controller_name == con_name
	end
end
