require 'rails_helper'

def basic_pass(path) #---❶
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Comments", type: :system do
  before do
    @blog = FactoryBot.create(:blog)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    basic_pass new_user_session_path
    fill_in 'email', with: @blog.user.email
    fill_in 'password', with: @blog.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # ブログ詳細ページに遷移する
    visit blog_path(@blog)
    # フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    click_button 'Send'
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq blog_path(@blog)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end
