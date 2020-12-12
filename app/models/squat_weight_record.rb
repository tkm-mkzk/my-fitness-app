class SquatWeightRecord < ApplicationRecord
  belongs_to :user
  validates :squat_weight, presence: true, numericality: { greater_than: 0 }
  validates :squat_day, presence: true, uniqueness: { scope: :user }
end
