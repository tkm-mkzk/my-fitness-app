require 'rails_helper'

RSpec.describe BenchPressWeightRecord, type: :model do
  describe 'ベンチプレス記録機能' do
    before do
      @bench_press_weight_record = FactoryBot.build(:bench_press_weight_record)
    end

    context 'ベンチプレスを記録できる時' do
      it 'bench_press_weight,bench_press_dayが存在すれば投稿できること' do
        expect(@bench_press_weight_record).to be_valid
      end
    end

    context 'ベンチプレスを記録できない時' do
      it 'bench_press_weightが空ではコメントできないこと' do
        @bench_press_weight_record.bench_press_weight = nil
        @bench_press_weight_record.valid?
        expect(@bench_press_weight_record.errors.full_messages).to include("Bench press weight can't be blank")
      end

      it 'bench_press_dayが空ではベンチプレスを記録できないこと' do
        @bench_press_weight_record.bench_press_day = nil
        @bench_press_weight_record.valid?
        expect(@bench_press_weight_record.errors.full_messages).to include("Bench press day can't be blank")
      end

      it 'userが空ではベンチプレスを記録できないこと' do
        @bench_press_weight_record.user = nil
        @bench_press_weight_record.valid?
        expect(@bench_press_weight_record.errors.full_messages).to include('User must exist')
      end

      it 'bench_press_weightが0ではベンチプレスを記録できないこと' do
        @bench_press_weight_record.bench_press_weight = 0
        @bench_press_weight_record.valid?
        expect(@bench_press_weight_record.errors.full_messages).to include('Bench press weight must be greater than 0')
      end

      it 'bench_press_weightが負の数ではベンチプレスを記録できないこと' do
        @bench_press_weight_record.bench_press_weight = -70
        @bench_press_weight_record.valid?
        expect(@bench_press_weight_record.errors.full_messages).to include('Bench press weight must be greater than 0')
      end
    end
  end
end
