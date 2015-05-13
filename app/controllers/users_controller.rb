class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter :get_user, only: [:posts, :edit, :update]

  def posts
    @posts ||= @user.posts.order("created_at DESC")
    render 'posts/index'
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email, :profile_photo)
  end

  def get_user
    @user = User.find params[:id]
  end
end