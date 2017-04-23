class AddNameFrInRole < ActiveRecord::Migration[5.0]
  def change
  	add_column :roles, :name_fr, :string
  	add_column :roles, :protected, :integer, :limit => 1, default: 0
  end
end
