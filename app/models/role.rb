class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates :email, presence: true
  validates :description, presence: true
  validates_uniqueness_of :user_id, scope: :team_id
end
