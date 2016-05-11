class Requirement < ActiveRecord::Base
  belongs_to :project
  default_scope -> {order(created_at: :desc)}
  validates :project_id, presence: true
  validates :description, presence: true, length: {maximum: 140}
  has_many :teams, through: :tasks
  has_many :sprints, through: :tasks
end
