class InsuranceFile < ApplicationRecord
	after_initialize do |ins_file|
    ins_file.ins_file = TempInsuranceFile.find(temp_id).ins_file if temp_id.present?
  end
  
  belongs_to :insurance
  has_one :temp_insurance_file, dependent: :destroy
  
  # accepts_nested_attributes_for :ins_file
  has_attached_file :ins_file
  validates_attachment_content_type :ins_file, :content_type => ["image/jpeg", "image/png","application/pdf",'application/msword','text/plain']
  attr_accessor :temp_id

  before_update :set_attachment

  def set_attachment
    self.ins_file = TempInsuranceFile.find(temp_id).ins_file if temp_id.present?
  end
end
