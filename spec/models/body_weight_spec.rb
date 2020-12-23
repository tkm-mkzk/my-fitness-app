require 'rails_helper'

RSpec.describe BodyWeight, type: :model do
  describe '体重記録機能' do
    before do
      @body_weight = FactoryBot.build(:body_weight)
    end

    context '体重を記録できる時' do
      it 'weight,dayが存在すれば投稿できること' do
        expect(@body_weight).to be_valid
      end
    end

    context '体重を記録できない時' do
      it 'weightが空ではコメントできないこと' do
        @body_weight.weight = nil
        @body_weight.valid?
        expect(@body_weight.errors.full_messages).to include("Weight can't be blank")
      end

      it 'dayが空では体重を記録できないこと' do
        @body_weight.day = nil
        @body_weight.valid?
        expect(@body_weight.errors.full_messages).to include("Day can't be blank")
      end

      it 'userが空では体重を記録できないこと' do
        @body_weight.user = nil
        @body_weight.valid?
        expect(@body_weight.errors.full_messages).to include('User must exist')
      end

      it 'weightが0では体重を記録できないこと' do
        @body_weight.weight = 0
        @body_weight.valid?
        expect(@body_weight.errors.full_messages).to include('Weight must be greater than 0')
      end

      it 'weightが負の数では体重を記録できないこと' do
        @body_weight.weight = -70
        @body_weight.valid?
        expect(@body_weight.errors.full_messages).to include('Weight must be greater than 0')
      end
    end
  end
end
