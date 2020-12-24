FactoryBot.define do
  factory :blog do
    title       { Faker::Lorem.sentence }
    target_site { 'arm' }
    content     { Faker::Lorem.sentence }
    association :user

    after(:build) do |blog|
      blog.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
