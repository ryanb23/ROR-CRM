class CreatePositionsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :positions_users do |t|
      t.references :user, foreign_key: true,index: true
      t.references :position, foreign_key: true ,index: true
    end
  end
end
