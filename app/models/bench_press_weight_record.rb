class BenchPressWeightRecord < ApplicationRecord
  belongs_to :user
  validates :bench_press_weight, presence: true, numericality: { greater_than: 0 }
  validates :bench_press_day, presence: true, uniqueness: { scope: :user }
end
