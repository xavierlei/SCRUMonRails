class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates :email, presence: true
  validates :description, presence: true
end
