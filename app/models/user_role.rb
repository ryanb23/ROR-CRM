class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
  # delegate :name_en,:id, :to => :role, :prefix => true
end
