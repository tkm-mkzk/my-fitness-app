class BlogsController < ApplicationController
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

  private

  def blog_params
    params.require(:blog).permit(:title, :target_site, :content, :image).merge(user_id: current_user.id)
  end
end
