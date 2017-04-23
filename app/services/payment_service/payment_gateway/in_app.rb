module PaymentService::PaymentGateway
	class InApp
		def initialize(opts={})
			@opts = opts
		end

		def process
			Success.new(@opts, I18n.t("payment.in_app.payment_success"), :paid, 200)
		end
	end
end