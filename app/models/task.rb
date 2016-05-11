class Task < ActiveRecord::Base
  belongs_to :team
  belongs_to :sprint
  belongs_to :requirement
  validates_uniqueness_of :requirement_id, scope: :sprint_id
  validates :team_id, presence: true
  validates :sprint_id, presence: true
  validates :requirement_id, presence: true
end
