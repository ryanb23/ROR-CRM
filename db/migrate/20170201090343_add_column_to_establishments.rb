class AddColumnToEstablishments < ActiveRecord::Migration[5.0]
  def change
    add_column :establishments,:address, :text
    add_column :establishments,:postal_code, :integer
    add_column :establishments,:city, :string
    add_column :establishments,:country, :string
  end
end
