require 'response/success'
require 'response/error'

module PaymentService
	class Payment

		PAYMENT_GATEWAY = {
			in_app: PaymentGateway::InApp
		}

		# set payment gateway
		def initialize(opts={})
			# if no payment gateway pass in service then get default payment gateway using 'default_payment_gateway' method
			@payment_gateway = (PAYMENT_GATEWAY[opts[:payment_gateway]] || default_payment_gateway).new(opts)
		end

		# Do payment based on payment gateway
		def process
			@payment_gateway.process
		end

		private

		def default_payment_gateway
			PAYMENT_GATEWAY[:in_app]
		end
	end
end