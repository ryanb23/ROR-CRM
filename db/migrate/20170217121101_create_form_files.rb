class CreateFormFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :form_files do |t|
      t.references :form, foreign_key: true

      t.timestamps
    end
  end
end
