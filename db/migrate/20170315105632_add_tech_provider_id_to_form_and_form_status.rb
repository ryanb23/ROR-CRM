class AddTechProviderIdToFormAndFormStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :tech_provider_id, :integer
    add_column :form_statuses, :tech_provider_id, :integer
  end
end
