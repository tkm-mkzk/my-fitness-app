require 'rails_helper'

RSpec.describe SquatWeightRecord, type: :model do
  describe 'スクワット記録機能' do
    before do
      @squat_weight_record = FactoryBot.build(:squat_weight_record)
    end

    context 'スクワットを記録できる時' do
      it 'squat_weight,squat_dayが存在すれば投稿できること' do
        expect(@squat_weight_record).to be_valid
      end
    end

    context 'スクワットを記録できない時' do
      it 'squat_weightが空ではコメントできないこと' do
        @squat_weight_record.squat_weight = nil
        @squat_weight_record.valid?
        expect(@squat_weight_record.errors.full_messages).to include("Squat weight can't be blank")
      end

      it 'squat_dayが空ではスクワットを記録できないこと' do
        @squat_weight_record.squat_day = nil
        @squat_weight_record.valid?
        expect(@squat_weight_record.errors.full_messages).to include("Squat day can't be blank")
      end

      it 'userが空ではスクワットを記録できないこと' do
        @squat_weight_record.user = nil
        @squat_weight_record.valid?
        expect(@squat_weight_record.errors.full_messages).to include('User must exist')
      end

      it 'squat_weightが0ではスクワットを記録できないこと' do
        @squat_weight_record.squat_weight = 0
        @squat_weight_record.valid?
        expect(@squat_weight_record.errors.full_messages).to include('Squat weight must be greater than 0')
      end

      it 'squat_weightが負の数ではスクワットを記録できないこと' do
        @squat_weight_record.squat_weight = -70
        @squat_weight_record.valid?
        expect(@squat_weight_record.errors.full_messages).to include('Squat weight must be greater than 0')
      end
    end
  end
end
