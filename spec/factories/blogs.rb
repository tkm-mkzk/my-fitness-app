FactoryBot.define do
  factory :blog do
    title       { 'エニタイムフィットネス千歳烏山店でのトレーニング' }
    target_site { '腕、胸' }
    content     { '今日は胸周りの筋肉を中心にトレーニングを実施。ベンチプレスやインクラインダンベルプレス、ケーブルプレス、アームカールを行った。' }
    association :user

    after(:build) do |blog|
      blog.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
