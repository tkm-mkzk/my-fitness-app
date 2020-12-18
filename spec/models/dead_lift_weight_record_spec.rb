require 'rails_helper'

RSpec.describe DeadLiftWeightRecord, type: :model do
  describe 'デッドリフト記録機能' do
    before do
      @dead_lift_weight_record = FactoryBot.build(:dead_lift_weight_record)
    end

    context 'デッドリフトを記録できる時' do
      it 'dead_lift_weight,dead_lift_dayが存在すれば投稿できること' do
        expect(@dead_lift_weight_record).to be_valid
      end

    end

    context 'デッドリフトを記録できない時' do
      it 'dead_lift_weightが空ではコメントできないこと' do
        @dead_lift_weight_record.dead_lift_weight = nil
        @dead_lift_weight_record.valid?
        expect(@dead_lift_weight_record.errors.full_messages).to include("Dead lift weight can't be blank")
      end

      it 'dead_lift_dayが空ではデッドリフトを記録できないこと' do
        @dead_lift_weight_record.dead_lift_day = nil
        @dead_lift_weight_record.valid?
        expect(@dead_lift_weight_record.errors.full_messages).to include("Dead lift day can't be blank")
      end

      it 'userが空ではデッドリフトを記録できないこと' do
        @dead_lift_weight_record.user = nil
        @dead_lift_weight_record.valid?
        expect(@dead_lift_weight_record.errors.full_messages).to include('User must exist')
      end

      it 'dead_lift_weightが0ではデッドリフトを記録できないこと' do
        @dead_lift_weight_record.dead_lift_weight = 0
        @dead_lift_weight_record.valid?
        expect(@dead_lift_weight_record.errors.full_messages).to include('Dead lift weight must be greater than 0')
      end

      it 'dead_lift_weightが負の数ではデッドリフトを記録できないこと' do
        @dead_lift_weight_record.dead_lift_weight = -70
        @dead_lift_weight_record.valid?
        expect(@dead_lift_weight_record.errors.full_messages).to include('Dead lift weight must be greater than 0')
      end

    end
  end
end
