class BodyWeightsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_user
  before_action :allow_correct_user, only: [:create, :update, :destroy]

  def index
    @body_weight = BodyWeight.new
    @body_weights = BodyWeight.all
  end

  def update
    @body_weight = BodyWeight.find(params[:id])
    return  redirect_to user_body_weights_path(@user), notice: '編集しました' if @body_weight.update(weight_params)
    redirect_to user_body_weights_path(@user), flash: { alert: '編集に失敗しました', error_messages: @body_weight.errors.full_messages }
  end

  def destroy
    @body_weight = BodyWeight.find(params[:id])
    @body_weight.destroy
    redirect_to user_body_weights_path(@user), notice: '削除しました'
  end

  private

  def weight_params
    params.require(:body_weight).permit(:weight, :day).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def allow_correct_user
    redirect_to user_body_weights_path(@user) unless @user == current_user
  end
end
