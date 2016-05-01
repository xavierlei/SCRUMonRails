class Requirement < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true
  validates :description, presence: true, length: {maximum: 140}
end
