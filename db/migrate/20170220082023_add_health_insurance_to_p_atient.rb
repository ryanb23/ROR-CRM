class AddHealthInsuranceToPAtient < ActiveRecord::Migration[5.0]
  def change
  	add_column :patients, :health_insurance, :string
  	add_column :forms, :note, :string
  end
end
