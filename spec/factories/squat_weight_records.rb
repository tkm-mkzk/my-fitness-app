FactoryBot.define do
  factory :squat_weight_record do
    squat_weight  { 100 }
    squat_day     { '2020-12-17' }
    association :user
  end
end
