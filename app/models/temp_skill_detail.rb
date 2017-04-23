class TempSkillDetail < ApplicationRecord
  enum operation_status: { :added => 0, :change => 1, :removed => 2 }

  belongs_to :user_temp_detail
  belongs_to :skill

  has_attached_file :proof
  validates_attachment_content_type :proof, :content_type => ["image/jpeg", "image/png", "image/jpg"]
  validates_attachment_size :proof, :less_than => 1.megabytes

  scope :change_and_removed, -> { where(operation_status: [:change, :removed]) }
  scope :filter_by_association, -> (skill_id) { where(skill_id: skill_id ) }
end
