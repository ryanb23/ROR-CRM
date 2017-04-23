class Users::PasswordExpiredController < Devise::PasswordExpiredController

	# def show
	# 	# exit
	# 	id = current_user.id
	# 	PasswordExpiredMailer.password_change(id).deliver
	# 	# redirect_to root_path
	# 	# super
	# end

	def change_password
	end

	def update_password
		flash.clear
		@user = User.find_by(email: params[:email])
		if @user.update_attributes(password: params[:password],password_confirmation: params[:password_confirmation],password_changed_at: Time.now)
			flash[:notice] = 'Successfully updated password'
			redirect_to root_path
		else
			flash[:notice] = 'Please enter valid information'
			render "change_password"
		end
	end
end