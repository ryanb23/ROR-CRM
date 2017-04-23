class AddNameEnInSpeciality < ActiveRecord::Migration[5.0]
  def change
    add_column :specialities, :name_en, :string
  end
end
