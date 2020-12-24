require 'rails_helper'

def basic_pass(path) #---❶
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "BenchPressWeightRecords", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @bench_press_weight_record = FactoryBot.create(:bench_press_weight_record)
  end

  it 'ログインしたユーザーはベンチプレスインデックスページでベンチプレスを記録できる' do
    # ログインする
    basic_pass new_user_session_path
    fill_in 'email', with: @bench_press_weight_record.user.email
    fill_in 'password', with: @bench_press_weight_record.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # ベンチプレスインデックスページに遷移する
    visit user_bench_press_weight_records_path(@bench_press_weight_record.user.id)
    # Record weightボタンをクリックしてフォームを表示させる
    click_button 'Record weight'
    # フォームに情報を入力する
    fill_in 'bench_press_weight_record_bench_press_weight', with: @bench_press_weight_record.bench_press_weight
    # ベンチプレスを記録すると、body_weighyモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { BenchPressWeightRecord.count }.by(1)
    # インデックスページにリダイレクトされることを確認する
    expect(current_path).to eq user_bench_press_weight_records_path(@bench_press_weight_record.user.id)
  end
end
