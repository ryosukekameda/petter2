class Public::FavoritesController < ApplicationController
  def index
    @favorite_posts = Post.joins(:favorites).where(favorites: { user_id: current_user.id }).order('favorites.created_at DESC')
  end
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end
end
