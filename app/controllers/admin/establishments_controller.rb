class Admin::EstablishmentsController < Admin::BaseController
	include Authorizations
 #  load_and_authorize_resource
	# before_filter :load_permissions

  def create
    super do |resource|
    	resource.subscriptions.build(subscription_date: Time.now,plan_id: resource.plan_id).save
    end
  end

  def update
    super do |resource|
    	r = resource.subscriptions.where(entity_id: resource.id)
      if r.present?
    	  r.update_all(plan_id: resource.plan_id)
      else
        resource.subscriptions.build(subscription_date: Time.now,plan_id: resource.plan_id).save
      end
    end
  end

  private

  def permitted_attributes
    ["salesman_id", "name", "iban", "bic", "address", "postal_code", "city", "country","plan_id"]
  end
end
