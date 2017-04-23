class AddRolesToUser < ActiveRecord::Migration[5.0]
	# Add patient role to users who don't have any role
  def change
  	User.with_deleted.find_each do |user|
			if user.roles.empty?
				user.roles << Role.patient.first
			end
		end
  end
end
