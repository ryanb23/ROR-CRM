class PaymentsController < ApplicationController
	def create
		@form = Form.find(params[:payment][:form_id])
		payment_response = PaymentService::Payment.new(
			card_number: params[:payment][:card_number],
			expire_date: expire_on_date,
			cvv_number: params[:payment][:cvv_number],
			amount: @form.invoices_patients.first.amount
		).process

		@payment = @form.payments.new(payment_params.merge(amount: payment_response.data[:amount], status: payment_response.status, payment_response: payment_response.as_json)).save
		if @payment
			@form.provider_pending!
		end
		redirect_to root_path, notice: payment_response.message
	end

	private

	def payment_params
		update_params_with_valid_exp_date
		params.require(:payment).permit(:card_number, :expire_on)
	end

	def expire_on_date
		Date.new(params[:payment][:expire_year].to_i, params[:payment][:expire_month].to_i)
	end

	def update_params_with_valid_exp_date
		params[:payment][:expire_on] = expire_on_date
	end
end
