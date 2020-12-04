class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def set_blog
    @user = User.find(params[:id])
  end
end
