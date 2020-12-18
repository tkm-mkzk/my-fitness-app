FactoryBot.define do
  factory :dead_lift_weight_record do
    dead_lift_weight  {180}
    dead_lift_day     {"2020-12-17"}
    association :user
  end
end
