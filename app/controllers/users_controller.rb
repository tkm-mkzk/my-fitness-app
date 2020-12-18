class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @blogs = @user.blogs.order(updated_at: :desc).page(params[:page]).per(3)
    @current_body_weight = @user.body_weights.order(updated_at: :desc).limit(1)
    @current_bench_press_weight = @user.bench_press_weight_records.order(updated_at: :desc).limit(1)
    @current_dead_lift_weight = @user.dead_lift_weight_records.order(updated_at: :desc).limit(1)
    @current_squat_weight = @user.squat_weight_records.order(updated_at: :desc).limit(1)
    @body_weights = @user.body_weights.all
    @bench_press_weight_records = @user.bench_press_weight_records.all
    @dead_lift_weight_records = @user.dead_lift_weight_records.all
    @squat_weight_records = @user.squat_weight_records.all

    a = if @current_bench_press_weight[0].nil?
          0
        else
          @current_bench_press_weight[0].bench_press_weight
        end

    b = if @current_squat_weight[0].nil?
          0
        else
          @current_squat_weight[0].squat_weight
        end

    c = if @current_dead_lift_weight[0].nil?
          0
        else
          @current_dead_lift_weight[0].dead_lift_weight
        end

    @total_big3 = a + b + c
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to edit_user_registration_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
