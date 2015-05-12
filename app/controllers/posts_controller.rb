class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :add_comment]
  before_filter :get_post, except: [:index, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def index
    page_number = params["page"] || 1
    @posts = Post.page(page_number).order('created_at DESC')
  end

  def show
  end

  def add_comment
    post.comments.create(user_id: params[:comment][:user_id], thought: params[:comment][:thought])
    redirect_to post_path(post.id)
  end

  private

  def post_params
    params.require(:post).permit(:id, :title, :description, :country, :place, :visited_on, :photo, :user_id)
  end

  def get_post
    @post = Post.find params[:id]
  end
end