class ChangeEndDateDatatypeInInsurances < ActiveRecord::Migration[5.0]
  def change
  	change_column :insurances, :end_date, :date
  end
end
