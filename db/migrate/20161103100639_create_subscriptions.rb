class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.integer :entity_id
      t.string :entity_type
      t.datetime :subscription_date
      t.references :plan, foreign_key: true

      t.timestamps
    end
    add_index :subscriptions, [:entity_type, :entity_id]
  end
end
