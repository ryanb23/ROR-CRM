class AddMailStatusInForm < ActiveRecord::Migration[5.0]
  def change
  	add_column :forms, :mail_status, :integer, :null => false, :default => 24
  end
end
