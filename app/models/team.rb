class Team < ActiveRecord::Base
  belongs_to :project
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_many :tasks, dependent: :destroy
  has_many :requirements, through: :tasks
  has_many :sprints, through: :tasks
  validates_uniqueness_of :name, scope: :project_id
  default_scope ->{order(created_at: :desc)}
end
