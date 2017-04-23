class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :subject_class
      t.string :action
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
