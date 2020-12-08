class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @blogs = @user.blogs
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
