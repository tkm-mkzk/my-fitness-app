FactoryBot.define do
  factory :user do
    nickname              { 'muscle太郎' }
    email                 { Faker::Internet.free_email }
    password              { 'aaa111' }
    password_confirmation { password }
    private               { 1 }
  end
end
