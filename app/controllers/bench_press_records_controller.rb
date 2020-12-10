class BenchPressRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :allow_correct_user, only: [:create, :update, :destroy]

  def index
    @bench_press_record = BenchPressRecord.new
    # @body_weights = current_user.body_weights
    standard_date = Time.current
    standard_date = Time.current.ago(params[:date].to_i.weeks) if params[:date]
    # 表示用範囲設定
    @date_range = standard_date.beginning_of_week.to_date..standard_date.end_of_week.to_date # 一週間分
    @dailychart_range = standard_date.all_week # 一週間分
    @weeklychart_range = standard_date.ago(1.month).beginning_of_month..standard_date.end_of_month # 二ヶ月分
    @monthlychart_range = standard_date.all_year # 一年分
    # 一週間より一つ前のレコードの体重の取得（前回比用）
    last_weight_record = @user.bench_press_records.order(day: :desc).where('day < ? ', standard_date.beginning_of_week).first
    @last_weight = last_weight_record.weight if last_weight_record
    # 曜日表示用
    @weeks = %w[Sun Mon Tue Wed Thu Fri Sat]
  end

  def create
    @bench_press_record = current_user.bench_press_records.build(bench_params)
    return redirect_to user_bench_press_records_path(@user), notice: 'Recorded bench press record' if @bench_press_record.save
    # レンダリングでは諸々の変数を設定しないといけないためリダイレクトに設定
    redirect_to user_bench_press_records_path(@user), flash: { alert: 'Recording failed', error_messages: @bench_press_record.errors.full_messages }
  end

  def update
    @bench_press_record = BenchPressRecord.find(params[:id])
    return redirect_to user_bench_press_records_path(@user), notice: 'Edited' if @bench_press_record.update(bench_params)
    redirect_to user_bench_press_records_path(@user), flash: { alert: 'Editing failed', error_messages: @bench_press_record.errors.full_messages }
  end

  def destroy
    @bench_press_record = BodyWeight.find(params[:id])
    @bench_press_record.destroy
    redirect_to user_bench_press_records_path(@user), notice: 'Deleted'
  end

  private

  def bench_params
    params.require(:bench_press_record).permit(:weight, :day)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def allow_correct_user
    redirect_to user_bench_press_records_path(@user) unless @user == current_user
  end
end
