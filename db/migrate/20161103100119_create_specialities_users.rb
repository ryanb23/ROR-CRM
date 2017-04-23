class CreateSpecialitiesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :specialities_users do |t|
    	t.belongs_to :user
      t.belongs_to :speciality
    end
  end
end
