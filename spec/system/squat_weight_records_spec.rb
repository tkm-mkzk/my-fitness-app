require 'rails_helper'

def basic_pass(path) #---❶
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "SquatWeightRecords", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @squat_weight_record = FactoryBot.create(:squat_weight_record)
  end

  it 'ログインしたユーザーは体重インデックスページで体重を記録できる' do
    # ログインする
    basic_pass new_user_session_path
    fill_in 'email', with: @squat_weight_record.user.email
    fill_in 'password', with: @squat_weight_record.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 体重インデックスページに遷移する
    visit user_squat_weight_records_path(@squat_weight_record.user.id)
    # Record weightボタンをクリックしてフォームを表示させる
    click_button 'Record weight'
    # フォームに情報を入力する
    fill_in 'squat_weight_record_squat_weight', with: @squat_weight_record.squat_weight
    # 体重を記録すると、body_weighyモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { SquatWeightRecord.count }.by(1)
    # インデックスページにリダイレクトされることを確認する
    expect(current_path).to eq user_squat_weight_records_path(@squat_weight_record.user.id)
  end
end
