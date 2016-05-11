class Sprint < ActiveRecord::Base
  belongs_to :project
  validates :begin_date, presence: true
  validates :end_date, presence: true
  has_many :teams, through: :tasks
  has_many :requirements, through: :tasks
  default_scope ->{order(begin_date: :asc)}
  validate :future_date?
  validate :end_is_after_begin?
  def future_date?
    if begin_date < Date.today
      errors.add(:begin_date, "can't be in the past")
    end
  end

  def end_is_after_begin?
    if begin_date > end_date
      errors.add(:end_date,"can't be before begin date")
    end
  end
end
