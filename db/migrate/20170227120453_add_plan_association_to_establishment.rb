class AddPlanAssociationToEstablishment < ActiveRecord::Migration[5.0]
  def change
    add_reference :establishments, :plan, foreign_key: true
  end
end
