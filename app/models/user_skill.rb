class UserSkill < ApplicationRecord
  after_initialize do |user_skill|
    user_skill.proof = TempSkillDetail.find(temp_id).proof if temp_id.present?
  end
  belongs_to :user
  belongs_to :skill
  has_one :temp_skill_detail
  
  delegate :name_en, to: :skill, :prefix=>true
  delegate :name_fr, to: :skill, :prefix=>true
  
  has_attached_file :proof
  validates_attachment_content_type :proof, :content_type => ["image/jpeg", "image/png", "image/jpg"]
  validates_attachment_size :proof, :less_than => 1.megabytes
  validates :skill_id,presence: true

  before_update :set_attachment

  attr_accessor :temp_id

  def set_attachment
    self.proof = TempSkillDetail.find(temp_id).proof if temp_id.present?
  end

end
