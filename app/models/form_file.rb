class FormFile < ApplicationRecord
  belongs_to :form
  file_virtual_path = "/system/form_files/:rails_env/:hashed_path/:id/:style/:basename.:extension"
  file_real_path = ":rails_root/public" + file_virtual_path
  has_attached_file :file, :path => file_real_path, :url => file_virtual_path, :styles => { :medium => "300x300>",:thumb => "100x100>"}
  validates_attachment_content_type :file, :content_type => ["image/jpeg", "image/png", "image/jpg"]
  # validates_length_of :, :maximum => 255
end