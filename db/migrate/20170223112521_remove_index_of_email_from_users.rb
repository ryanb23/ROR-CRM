class RemoveIndexOfEmailFromUsers < ActiveRecord::Migration[5.0]
  def change
  	# To remove uniquness of email. Need to save blank email field if user have no email and need to save user's details without email
  	remove_index :users, :email
  	add_index :users, :email
  end
end
