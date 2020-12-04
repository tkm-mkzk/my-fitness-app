class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :move_to_index]
  before_action :move_to_index, only: :edit

  def index
    @blogs = Blog.all.order('created_at DESC')
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.valid?
      @blog.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog.id)
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @item.user.id
      @item.destroy
      redirect_to root_path
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :target_site, :content, :image).merge(user_id: current_user.id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @blog.user_id
  end
end
