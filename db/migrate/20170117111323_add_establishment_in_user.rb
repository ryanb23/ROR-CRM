class AddEstablishmentInUser < ActiveRecord::Migration[5.0]
  def change
  	add_reference :users, :establishment, index: true
  	add_reference :users, :establishment_service, index: true
  end
end
