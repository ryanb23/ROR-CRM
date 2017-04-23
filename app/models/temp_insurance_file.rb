class TempInsuranceFile < ApplicationRecord
	after_initialize do |temp_insurance_file|
    temp_insurance_file.ins_file = InsuranceFile.find(temp_id).ins_file if temp_id.present?
	end
  enum operation_status: { :added => 0, :change => 1, :removed => 2 }
  
  belongs_to :temp_insurance_detail
  belongs_to :insurance_file
  
  has_attached_file :ins_file
  validates_attachment_content_type :ins_file, :content_type => ["image/jpeg", "image/png","application/pdf",'application/msword','text/plain']
  attr_accessor :temp_id
end
