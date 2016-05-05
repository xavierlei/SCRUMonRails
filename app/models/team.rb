class Team < ActiveRecord::Base
  belongs_to :project
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  default_scope ->{order(created_at: :desc)}
end
