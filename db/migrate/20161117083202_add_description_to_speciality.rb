class AddDescriptionToSpeciality < ActiveRecord::Migration[5.0]
  def change
    add_column :specialities, :description, :string
  end
end
