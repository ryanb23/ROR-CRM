class PasswordExpiredMailer < ApplicationMailer
	def password_change(id)
		@user = User.find(id)
    mail to: @user.email, subject: "Your password has expired"
    # @url = users_password_expired_change_password_url
	end
end