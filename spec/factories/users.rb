FactoryBot.define do
  factory :user do
    nickname              {"muscle太郎"}
    email                 {Faker::Internet.free_email}
    password              {"aaa111"}
    password_confirmation {password}
  end
end
