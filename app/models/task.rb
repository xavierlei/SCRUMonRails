class Task < ActiveRecord::Base
  belongs_to :team
  belongs_to :sprint
  belongs_to :requirement
end
