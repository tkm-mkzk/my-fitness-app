class BodyWeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :allow_correct_user, only: [:create, :update, :destroy]

  def index
    @body_weight = BodyWeight.new
    @body_weights = current_user.body_weights
    standard_date = Time.current
    standard_date = Time.current.ago(params[:date].to_i.weeks) if params[:date]
    # 表示用範囲設定
    @date_range = standard_date.beginning_of_week.to_date..standard_date.end_of_week.to_date # 一週間分
    @dailychart_range = standard_date.all_week # 一週間分
    @weeklychart_range = standard_date.all_month # 一ヶ月分
    @monthlychart_range = standard_date.all_year # 一年分
    # 一週間より一つ前のレコードの体重の取得（前回比用）
    last_weight_record = @user.body_weights.order(day: :desc).where('day < ? ', standard_date.beginning_of_week).first
    @last_weight = last_weight_record.weight if last_weight_record
    # 曜日表示用
    @weeks = %w[Sun Mon Tue Wed Thu Fri Sat]
  end

  def create
    @body_weight = current_user.body_weights.build(weight_params)
    return redirect_to user_body_weights_path(@user), notice: 'Recorded body weight' if @body_weight.save

    # レンダリングでは諸々の変数を設定しないといけないためリダイレクトに設定
    redirect_to user_body_weights_path(@user), flash: { alert: 'Recording failed', error_messages: @body_weight.errors.full_messages }
  end

  def update
    @body_weight = BodyWeight.find(params[:id])
    return redirect_to user_body_weights_path(@user), notice: 'Successfully edited' if @body_weight.update(weight_params)

    redirect_to user_body_weights_path(@user), flash: { alert: 'Editing failed', error_messages: @body_weight.errors.full_messages }
  end

  def destroy
    @body_weight = BodyWeight.find(params[:id])
    @body_weight.destroy
    redirect_to user_body_weights_path(@user), notice: 'Deleted'
  end

  private

  def weight_params
    params.require(:body_weight).permit(:weight, :day)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def allow_correct_user
    redirect_to user_body_weights_path(@user) unless @user == current_user
  end
end
