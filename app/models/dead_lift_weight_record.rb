class DeadLiftWeightRecord < ApplicationRecord
  belongs_to :user
  validates :dead_lift_weight, presence: true, numericality: { greater_than: 0 }
  validates :dead_lift_day, presence: true, uniqueness: { scope: :user }
end
