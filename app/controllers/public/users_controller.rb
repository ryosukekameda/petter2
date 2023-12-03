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
    @user = current_user
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def follows
    user = User.find(params[:id])
    @user = current_user
    @users = user.following_users
  end
  
  def followers
    user = User.find(params[:id])
    @user = current_user
    @users = user.follower_users
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
