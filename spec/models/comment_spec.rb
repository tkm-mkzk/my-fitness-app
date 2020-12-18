require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント機能' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    context 'コメントできる時' do
      it 'textが存在すれば投稿できること' do
        expect(@comment).to be_valid
      end

    end

    context 'コメントできない時' do
      it 'textが空ではコメントできないこと' do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")

      end
    end
  end
end
