require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe '日記投稿機能' do
    before do
      @blog = FactoryBot.build(:blog)
    end

    context '日記投稿できる時' do
      it 'image、title、target_site、contentが存在すれば投稿できること' do
        expect(@blog).to be_valid
      end

      it 'imageがなくても投稿できること' do
        @blog.image = nil
        expect(@blog).to be_valid
      end
    end

    context '日記投稿できない時' do
      it 'titleが空では投稿できないこと' do
        @blog.title = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Title can't be blank")
      end

      it 'target_siteが空では投稿できないこと' do
        @blog.target_site = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Target site can't be blank")
      end

      it 'contentが空では投稿できないこと' do
        @blog.content = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include("Content can't be blank")
      end
    end
  end
end
