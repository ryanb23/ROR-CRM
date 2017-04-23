class RenameNameFieldInSpeciality < ActiveRecord::Migration[5.0]
  def change
    rename_column :specialities, :name, :name_fr
  end
end
