class DelCustomer < ApplicationRecord
	belongs_to :user , :foreign_key => :customer_id , class_name: "User"
	belongs_to :user , :foreign_key => :delegate_customer_id , class_name: "User"
end
