class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.text :redirect_url
      t.string :action
      t.boolean :is_read, default: false
      t.references :user, foreign_key: true
      t.integer :recipient_id
      t.references :notifiable, polymorphic: true

      t.timestamps
    end
  end
end
