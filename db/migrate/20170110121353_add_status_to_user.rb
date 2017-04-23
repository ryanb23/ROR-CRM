class AddStatusToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :emp_status, :integer
  end
end
