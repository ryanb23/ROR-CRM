class InsuranceMailer < ApplicationMailer
  default from: 'z@gmail.com'

	def notify_before_insurance_expired(user)
		@user = user
		# admin_emails = (defined? AdminUser) == "constant" ? AdminUser.pluck(:email) : [] # Remove this line after remove AdminUser table
		# admin_emails << Role.find_by(name_en: "Root", name_fr: "Super Admin").users.pluck(:email)
    mail(to: @user.email, bcc: get_admin_emails, subject: 'Your insurance will be expired in month')
	end

	def notify_after_insurance_expired(user)
		@user = user
    mail(to: @user.email, bcc: get_admin_emails, subject: 'Your insurance is expired')
	end

	private

	def get_admin_emails
		# Remove email fetch code from AdminUser after delete AdminUser table.
		((defined? AdminUser) == "constant" ? AdminUser.pluck(:email) : []) << Role.find_by(name_en: "Root", name_fr: "Super Admin").users.pluck(:email)
	end
end
