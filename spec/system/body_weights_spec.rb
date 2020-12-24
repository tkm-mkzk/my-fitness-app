require 'rails_helper'

def basic_pass(path) #---❶
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "BodyWeights", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @body_weight = FactoryBot.create(:body_weight)
  end

  it 'ログインしたユーザーは体重インデックスページで体重を記録できる' do
    # ログインする
    basic_pass new_user_session_path
    fill_in 'email', with: @body_weight.user.email
    fill_in 'password', with: @body_weight.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 体重インデックスページに遷移する
    visit user_body_weights_path(@body_weight.user.id)
    # Record weightボタンをクリックしてフォームを表示させる
    click_button 'Record weight'
    # フォームに情報を入力する
    fill_in 'body_weight_weight', with: @body_weight.weight
    # 体重を記録すると、body_weighyモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { BodyWeight.count }.by(1)
    # インデックスページにリダイレクトされることを確認する
    expect(current_path).to eq user_body_weights_path(@body_weight.user.id)
  end
end
