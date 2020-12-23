require 'rails_helper'

def basic_pass(path) #---❶
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "ブログ投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @blog = FactoryBot.create(:blog)
    @blog_image = Faker::Lorem.sentence
  end

  context 'ブログ投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      basic_pass new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがある
      expect(page).to have_content('New blog')
      # 投稿ページに移動する
      visit new_blog_path
      # フォームに情報を入力する
      fill_in 'blog_title', with: @blog.title
      check 'blog_target_site_chest'
      fill_in 'blog_content', with: @blog.content
      # 送信するとBlogモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Blog.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容のブログが存在する（画像）
      expect(page).to have_selector("img[src$='no_image-590325f09406e62c7922dd178a3e67754bd98555caa5783b2c4aae0e92c22c0c.png']")
      # トップページには先ほど投稿した内容のブログが存在する（タイトル）
      expect(page).to have_content(@blog.title)
      # トップページには先ほど投稿した内容のブログが存在する（鍛えた部位）
      expect(page).to have_content(@blog.target_site)
      # トップページには先ほど投稿した内容のブログが存在する（メニューや感想）
      expect(page).to have_content(@blog_content)
    end
  end
  context 'ブログ投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('New blog')
    end
  end
end

RSpec.describe 'ブログ編集', type: :system do
  before do
    @blog1 = FactoryBot.create(:blog)
    @blog2 = FactoryBot.create(:blog)
  end
  context 'ブログ編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したブログの編集ができる' do
      # ブログ1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'email', with: @blog1.user.email
      fill_in 'password', with: @blog1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ブログ1の詳細画面に遷移する
      visit blog_path(@blog1)
      # 編集ページへ遷移する
      visit edit_blog_path(@blog1)
      # すでに投稿済みの内容がフォームに入っている
      expect(
        find('#blog_title').value
      ).to eq @blog1.title
      expect(
        find('#blog_content').value
      ).to eq @blog1.content
      # 投稿内容を編集する
      fill_in 'blog_title', with: "胸トレ"
      fill_in 'blog_content', with: "ベンチプレス85kg✕3"
      # 編集してもBlogモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Blog.count }.by(0)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のブログが存在する
      expect(page).to have_content "胸トレ"
      expect(page).to have_content "ベンチプレス85kg✕3"
    end
  end
  context 'ブログ編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したブログの編集画面には遷移できない' do
      # ブログ1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'email', with: @blog1.user.email
      fill_in 'password', with: @blog1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ブログ2の詳細画面に遷移する
      visit blog_path(@blog2)
      # ブログ2に「編集」ボタンがない
      expect("a").to have_no_link 'dit', href: '/blogs/@blog1.id/edit'
    end
  end
end

RSpec.describe 'ブログ削除', type: :system do
  before do
    @blog1 = FactoryBot.create(:blog)
    @blog2 = FactoryBot.create(:blog)
  end
  context 'ブログ削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したブログの削除ができる' do
      # ブログ1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'email', with: @blog1.user.email
      fill_in 'password', with: @blog1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ブログ1の詳細画面に遷移する
      visit blog_path(@blog1)
      # 投稿を削除するとレコードの数が1減る
      page.accept_confirm do
        click_link 'Del'
      end
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページにはブログ1の内容が存在しない
      expect(page).to have_no_content("#{@blog1.title}")
      expect(page).to have_no_content("#{@blog1.content}")
    end
  end
  context 'ブログ削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したブログの削除ができない' do
      # ブログ1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'email', with: @blog1.user.email
      fill_in 'password', with: @blog1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ブログ2の詳細画面に遷移する
      visit blog_path(@blog2)
      # ブログ2に「削除」ボタンが無い
      expect('a').to have_no_link 'Del', href: blog_path(@blog2)
    end
  end
end

RSpec.describe 'ブログ詳細', type: :system do
  before do
    @blog = FactoryBot.create(:blog)
  end
  it 'ログインしたユーザーはブログ詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    basic_pass new_user_session_path
    fill_in 'email', with: @blog.user.email
    fill_in 'password', with: @blog.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 詳細ページに遷移する
    visit blog_path(@blog)
    # 詳細ページにブログの内容が含まれている
    expect(page).to have_content("#{@blog.title}")
    expect(page).to have_content("#{@blog.content}")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
end
