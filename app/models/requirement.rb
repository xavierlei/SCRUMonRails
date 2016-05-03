class Requirement < ActiveRecord::Base
  belongs_to :project
  default_scope -> {order(created_at: :desc)}
  validates :project_id, presence: true
  validates :description, presence: true, length: {maximum: 140}
end
