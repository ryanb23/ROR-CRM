class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.integer :form_type, :limit => 3
      t.string :name
      t.references :patient, foreign_key: true
      t.integer :users, :customer_id, foreign_key: true
      t.integer :users, :provider_id, foreign_key: true
      t.integer :users, :supervisor_id, foreign_key: true
      t.string :medical_context
      t.integer :status, :limit => 3

      t.timestamps
    end
  end
end
