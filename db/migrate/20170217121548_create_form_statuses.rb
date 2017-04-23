class CreateFormStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :form_statuses do |t|
      t.references :form, foreign_key: true
      t.references :patient, foreign_key: true
      t.integer :status,:limit => 3
      t.integer :users, :customer_id, foreign_key: true
      t.integer :users, :provider_id, foreign_key: true
      t.integer :users, :supervisor_id, foreign_key: true

      t.timestamps
    end
  end
end
