class Admin::InvoicesPatientsController < Admin::BaseController
  def class_search_params
    params.slice(:patient_id, :status)
  end
end
