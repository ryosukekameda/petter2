class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.page(params[:page]).per(3).reverse_order
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @followings = @user.following_users
    @follower = @user.follower_users
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render edit_users_path
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_user_status: true)
    reset_session
    redirect_to root_path
  end
  
  def follows
    user = User.find(params[:id])
    @users = user.followings_users
  end
  
  def followers
    user = User.find(params[:id])
    @user = user.follower_user
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    # @post = Post.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :nickname, :introduction, :phone_number, :header_image, :icon_image, :is_user_status)
  end
end
