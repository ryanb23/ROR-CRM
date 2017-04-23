class AddSalesmanIdToEstablishments < ActiveRecord::Migration[5.0]
  def change
    add_column :establishments,:salesman_id, :text
  end
end
