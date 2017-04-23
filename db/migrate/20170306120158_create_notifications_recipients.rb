class CreateNotificationsRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications_recipients do |t|
      t.references :notification, foreign_key: true
      t.integer :recipient_id

      t.timestamps
    end
  end
end
