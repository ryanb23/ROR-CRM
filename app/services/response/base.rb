module Response
	class Base
		attr_reader :data, :message, :status, :status_code

		def initialize(data = nil, message = nil, status = nil, status_code = nil)
			@data = data
			@message = message
			@status_code = status_code
		end

	 	def success?
	 		raise NotImplementedError
		end

		def on_success(&block)
	 		raise NotImplementedError
		end

		def on_error(&block)
	 		raise NotImplementedError
		end
	end
end