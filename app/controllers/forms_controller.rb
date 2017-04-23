class FormsController < ApplicationController
  def payment_of_analysis
  	@form = Form.find_by(id: params[:id], name: params[:form_name])
  	return redirect_to root_path, flash: { error: "Invalid form" } if @form.nil?
  	# @form.find_by_name(params[:name])
  	@payment = Payment.new
  	@invoice = @form&.invoices_patients.first
  end
end
