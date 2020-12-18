FactoryBot.define do
  factory :comment do
    text {"すごい頑張ってますね。応援しています！"}
    association :user
    association :blog
  end
end
