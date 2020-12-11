class BenchPressWeightRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :allow_correct_user, only: [:create, :update, :destroy]

  def index
    @bench_press_weight_record = BenchPressWeightRecord.new
    @bench_press_weight_records = current_user.bench_press_weight_records
    standard_date = Time.current
    standard_date = Time.current.ago(params[:date].to_i.weeks) if params[:date]
    # 表示用範囲設定
    @date_range = standard_date.beginning_of_week.to_date..standard_date.end_of_week.to_date # 一週間分
    @dailychart_range = standard_date.all_week # 一週間分
    @weeklychart_range = standard_date.all_month # 一ヶ月分
    @monthlychart_range = standard_date.all_year # 一年分
    # 一週間より一つ前のレコードの体重の取得（前回比用）
    last_weight_record = @user.bench_press_weight_records.order(bench_press_day: :desc).where('bench_press_day < ? ', standard_date.beginning_of_week).first
    @last_weight = last_weight_record.bench_press_weight if last_weight_record
    # 曜日表示用
    @weeks = %w[Sun Mon Tue Wed Thu Fri Sat]
  end

  def create
    @bench_press_weight_record = current_user.bench_press_weight_records.build(bench_press_weight_params)
    return redirect_to user_bench_press_weight_records_path(@user), notice: 'Recorded bench press weight' if @bench_press_weight_record.save
    # レンダリングでは諸々の変数を設定しないといけないためリダイレクトに設定
    redirect_to user_bench_press_weight_records_path(@user), flash: { alert: 'Recording failed', error_messages: @bench_press_weight_record.errors.full_messages }
  end

  def update
    @bench_press_weight = BenchPressWeightRecord.find(params[:id])
    return redirect_to user_bench_press_weight_records_path(@user), notice: 'Edited' if @bench_press_weight.update(bench_press_weight_params)
    redirect_to user_bench_press_weight_records_path(@user), flash: { alert: 'Editing failed', error_messages: @bench_press_weight_record.errors.full_messages }
  end

  def destroy
    @bench_press_weight_record = BenchPressWeightRecord.find(params[:id])
    @bench_press_weight_record.destroy
    redirect_to user_bench_press_weight_records_path(@user), notice: 'Deleted'
  end

  private

  def bench_press_weight_params
    params.require(:bench_press_weight_record).permit(:bench_press_weight, :bench_press_day)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def allow_correct_user
    redirect_to user_bench_press_weight_records_path(@user) unless @user == current_user
  end
end
