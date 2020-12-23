FactoryBot.define do
  factory :bench_press_weight_record do
    bench_press_weight  { 100 }
    bench_press_day     { '2020-12-17' }
    association :user
  end
end
