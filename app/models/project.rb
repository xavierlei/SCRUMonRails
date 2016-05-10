class Project < ActiveRecord::Base
  belongs_to :user
  has_many :requirements, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :sprints, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 2048}
end
