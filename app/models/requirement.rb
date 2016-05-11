class Requirement < ActiveRecord::Base
  belongs_to :project
  default_scope -> {order(created_at: :desc)}
  validates :project_id, presence: true
  validates :description, presence: true, length: {maximum: 256}
  has_many :tasks, dependent: :destroy
  has_many :teams, through: :tasks
  has_many :sprints, through: :tasks
end
