class Sprint < ActiveRecord::Base
  belongs_to :project
  validates :begin, presence: true
  validates :end, presence: true
end
