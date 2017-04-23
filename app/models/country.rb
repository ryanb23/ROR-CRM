class Country < ApplicationRecord
	def name_with_tel_code
		"#{name}" + " (+#{telephone_code})"
	end
end
