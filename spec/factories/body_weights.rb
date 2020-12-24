FactoryBot.define do
  factory :body_weight do
    weight  { 70 }
    day     { '2020-12-17' }
    association :user
  end
end
