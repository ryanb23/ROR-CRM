class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :description
      t.integer :quota

      t.timestamps
    end
  end
end
