class Project < ActiveRecord::Base
  belongs_to :user
  has_many :requirements, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 140}
end
