class PostsController < ApplicationController
  respond_to :html, :js
  before_filter :mobile_redirect, if: :ensure_mobile?

  def index
    @categories = Category.all
    @posts = Post.published.limit(10)
    respond_with @posts, layout: render_layout?
  end

  def show
    @post = get_post
    @post.track :views, [:uniques, request.remote_ip]
    respond_with @post, layout: render_layout?
  end

  def edit
    @post = get_post
  end

  def update
    @post = get_post
    if @post.update_attributes(post_params)
      set_flash :success, object: @post
      redirect_to posts_path
    else
      set_flash :error, object: @post
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      set_flash :success, object: @post
      redirect_to posts_path
    else
      set_flash :error, object: @post
      render :new
    end
  end

private
  
  def mobile_redirect_path
    { index: -> { posts_path } ,
      show:  -> { post_path(params[:id]) } }
  end

  def get_post
    Post.where(id: params[:id]).first
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
