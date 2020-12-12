class SquatWeightRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :allow_correct_user, only: [:create, :update, :destroy]

  def index
    @squat_weight_record = SquatWeightRecord.new
    @squat_weight_records = current_user.squat_weight_records
    standard_date = Time.current
    standard_date = Time.current.ago(params[:date].to_i.weeks) if params[:date]
    # 表示用範囲設定
    @date_range = standard_date.beginning_of_week.to_date..standard_date.end_of_week.to_date # 一週間分
    @dailychart_range = standard_date.all_week # 一週間分
    @weeklychart_range = standard_date.all_month # 一ヶ月分
    @monthlychart_range = standard_date.all_year # 一年分
    # 一週間より一つ前のレコードの体重の取得（前回比用）
    last_weight_record = @user.squat_weight_records.order(squat_day: :desc).where('squat_day < ? ', standard_date.beginning_of_week).first
    @last_weight = last_weight_record.squat_weight if last_weight_record
    # 曜日表示用
    @weeks = %w[Sun Mon Tue Wed Thu Fri Sat]
  end

  def create
    @squat_weight_record = current_user.squat_weight_records.build(squat_weight_params)
    return redirect_to user_squat_weight_records_path(@user), notice: 'Recorded squat weight' if @squat_weight_record.save

    # レンダリングでは諸々の変数を設定しないといけないためリダイレクトに設定
    redirect_to user_squat_weight_records_path(@user), flash: { alert: 'Recording failed', error_messages: @squat_weight_record.errors.full_messages }
  end

  def update
    @squat_weight = SquatWeightRecord.find(params[:id])
    return redirect_to user_squat_weight_records_path(@user), notice: 'Edited' if @squat_weight.update(squat_weight_params)

    redirect_to user_squat_weight_records_path(@user), flash: { alert: 'Editing failed', error_messages: @squat_weight_record.errors.full_messages }
  end

  def destroy
    @squat_weight_record = SquatWeightRecord.find(params[:id])
    @squat_weight_record.destroy
    redirect_to user_squat_weight_records_path(@user), notice: 'Deleted'
  end

  private

  def squat_weight_params
    params.require(:squat_weight_record).permit(:squat_weight, :squat_day)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def allow_correct_user
    redirect_to user_squat_weight_records_path(@user) unless @user == current_user
  end
end
