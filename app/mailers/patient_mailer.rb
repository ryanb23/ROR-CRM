class PatientMailer < ApplicationMailer
  default from: 'olivier@digidust.com'

	def payment_pending_email(patient,user,form,invoice_patient)
    @user = user
    @patient = patient
    @form = form
    @invoice_patient = invoice_patient
     mail(to: @user.email, subject: 'Pay Analysis')
  end

  def payment_pending_reminder_email(patient,user,form)
  	@user = user
    @patient = patient
    @form = form
    mail(to: @user.email, subject: 'Payment Remaining Reminder')
  end
end
